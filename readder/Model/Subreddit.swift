//
//  Subreddit.swift
//  readder
//
//  Created by Fran González on 17/12/17.
//  Copyright © 2017 Fran González. All rights reserved.
//

// Representation of a subreddit with the data we need in order to save it in our "database"
// and do API requests later.
struct Subreddit {
    // Name of the subreddit that will be loaded. Example: nosleep.
    var name: String
    
    // Max time of the posts to be fetched. Since we're using /top as the way of getting
    // the posts, this indicates whether the post should be from hour, day, week...
    var time: String
}
