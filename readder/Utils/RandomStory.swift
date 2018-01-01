//
//  RandomStory.swift
//  readder
//
//  Created by Fran González on 31/12/17.
//  Copyright © 2017 Fran González. All rights reserved.
//

import Foundation

/**
 Retrieves a random story from a given array of stories generating a random number between 0 and the number
 of stories inside the array.
 
 - parameter from: Array containing all the stories from which we want the random one.
 
 - returns: A random story from the array given in the `from` parameter.
*/
func randomStory(from stories: [Story]) -> Story {
    let lowerBound: UInt32 = 0
    let upperBound = UInt32(stories.count)
    let randomIndex = arc4random_uniform(upperBound - lowerBound) + lowerBound
    
    return stories[Int(randomIndex)]
}
