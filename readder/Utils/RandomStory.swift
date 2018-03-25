//
//  RandomStory.swift
//  readder
//
//  Created by Fran González on 31/12/17.
//  Copyright © 2017 Fran González. All rights reserved.
//

import Foundation

// MARK: Extensions

/**
 Mutates the built-in Array to allow shuffling the elements.
 */
extension Array {
    /**
     Randomizes the order of the elements of the array.
     */
    mutating func shuffle() {
        for _ in 0 ..< count {
            sort { (_,_) in arc4random() < arc4random() }
        }
    }
}

// MARK: Texts utilities

/**
 Counts the number of words in a given text. Works filtering whitespaces, new lines and punctuation characters
 off the text and counting the remaining words. While this may not be 100% accurate, it does the job.
 
 - parameter of: Text to count the words from.
 
 - returns: The word count of the given text.
*/
func countWords(of text: String) -> Int {
    let characterSet = CharacterSet.whitespacesAndNewlines.union(.punctuationCharacters)
    let components = text.components(separatedBy: characterSet)
    let words = components.filter { !$0.isEmpty }
    
    return words.count
}

/**
 Computes the reading time of the specified text based on the number of words that the text has and the average
 reading time.
 
 - parameter of: Text to compute the time of.
 
 - returns: The number of minutes needed to read the text.
*/
func readingTime(of text: String) -> Int {
    let wordsPerMinute = 200
    let wordsInText = countWords(of: text)
    let textReadingTime = Float(wordsInText / wordsPerMinute)
    
    return Int(textReadingTime.rounded(.up))
}

// MARK: Random generation

/**
 Returns a random index between the two specified bounds.
 
 - parameter lowerBound: The lower bound of the random number. 0 by default.
 - parameter upperBound: The upper bound of the random number.
 
 - returns: Random Int between the two bounds.
*/
func randomNumber(lowerBound: Int = 0, upperBound: Int) -> Int {
    let lowerUInt = UInt32(lowerBound)
    let upperUInt = UInt32(upperBound)
    let randomIndex = arc4random_uniform(upperUInt - lowerUInt) + lowerUInt
    return Int(randomIndex)
}

/**
 Retrieves a random story from a given array of stories that's within the range of time that the user specified,
 normally 1 or 2 minutes top, if they didn't set the infinite time option.
 
 - parameter from: Array containing all the stories from which we want the random one.
 - parameter time: Minutes available that the user has.
 
 - returns: A random story from the array given in the `from` parameter.
*/
func randomStory(from stories: [Story], time: ReadingTimes) -> Story? {
    // If the user has "infinite" time just return the first random one.
    if (time == ReadingTimes.Infinite) {
        let randomIndex = randomNumber(upperBound: stories.count)
        return stories[randomIndex]
    }
    
    // Otherwise let's compute which one is within the specified time.
    let availableTime: Int = {
        switch (time) {
            case .OneMinute: return 1
            case .FiveMinutes: return 5
            case .TenMinutes: return 10
            case .Infinite: return -1
        }
    }()
    
    // Shuffle the array to try to make the algorithm a little bit less predictable, specially when dealing
    // with less posts.
    var shuffledStories = stories
    shuffledStories.shuffle()
    
    // Find the more suitable story.
    for randomStory in shuffledStories {
        // The reading time of the story should be between 0 and +1 minute of the specified available time.
        let storyReadingTime = readingTime(of: randomStory.content)
        let maximumTime = availableTime + 1
        
        if 0...maximumTime ~= storyReadingTime {
            return randomStory
        }
    }
    
    return nil
}
