//
//  Database.swift
//  readder
//
//  Created by Fran González on 21/12/17.
//  Copyright © 2017 Fran González. All rights reserved.
//

import RealmSwift

// Class defining the interactions with the database.
class Database {
    // MARK: Saved subreddits.
    
    // Checks whether the database contains anything and, if not, adds some random subreddits.
    static func initialize() {
        let realm = try! Realm()
        let results = realm.objects(Subreddit.self)
        
        if results.isEmpty {
            let subredditsToCreate = [("nosleep", "day"), ("lifeofnorman", "day")]
            
            try! realm.write() {
                for tuple in subredditsToCreate {
                    let subreddit = realm.create(Subreddit.self)
                    subreddit.name = tuple.0
                    subreddit.time = tuple.1
                }
            }
        }
    }
    
    // Retrieves all the saved subreddits.
    static func getSavedSubreddits() -> [Subreddit] {
        let realm = try! Realm()
        let results = realm.objects(Subreddit.self)
        
        return Array(results)
    }
    
    // Removes an specific subreddit from the list.
    static func removeSubreddit(_ subreddit: Subreddit) {
        let realm = try! Realm()
        
        try! realm.write {
            realm.delete(subreddit)
        }
    }
    
    // Returns an specific Subreddit by its name.
    static func getSubredditBy(name: String) -> Results<Subreddit> {
        let realm = try! Realm()
        
        return realm.objects(Subreddit.self).filter("name = '%@'", name)
    }
    
    // Saves the specified Subreddit instance to the database.
    static func add(name: String, time: String) {
        let realm = try! Realm()
        
        // Only add it if it's not added already.
        if getSubredditBy(name: name).count > 0 {
            return
        }
        
        try! realm.write {
            let subreddit = realm.create(Subreddit.self)
            subreddit.name = name
            subreddit.time = time
        }
    }
}
