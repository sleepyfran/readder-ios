//
//  RandomStory.swift
//  readder
//
//  Created by Fran González on 31/12/17.
//  Copyright © 2017 Fran González. All rights reserved.
//

import Foundation

func randomStory(from stories: [Story]) -> Story {
    let lowerBound: UInt32 = 0
    let upperBound = UInt32(stories.count)
    let randomIndex = arc4random_uniform(upperBound - lowerBound) + lowerBound
    
    return stories[Int(randomIndex)]
}
