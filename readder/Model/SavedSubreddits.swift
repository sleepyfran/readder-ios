//
//  SavedSubreddits.swift
//  readder
//
//  Created by Fran González on 17/12/17.
//  Copyright © 2017 Fran González. All rights reserved.
//

import RealmSwift

/**
 List of subreddits saved by the user for the `Realm` database.
*/
class SavedSubreddits: Object {
    let subreddits = List<Subreddit>()
}
