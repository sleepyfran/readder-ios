//
//  SavedSubreddits.swift
//  readder
//
//  Created by Fran González on 17/12/17.
//  Copyright © 2017 Fran González. All rights reserved.
//

import RealmSwift

// Saved subreddits of the user.
class SavedSubreddits: Object {
    let subreddits = List<Subreddit>()
}
