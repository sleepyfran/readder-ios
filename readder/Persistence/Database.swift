//
//  Database.swift
//  readder
//
//  Created by Fran González on 21/12/17.
//  Copyright © 2017 Fran González. All rights reserved.
//

import RealmSwift

/**
 Defines the interaction with the `Realm` database.
*/
class Database {
    // MARK: Saved subreddits.

    /**
     Checkes whether the database contains anything and, if not, adds some subreddits.
    */
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
    
    /**
     Retrieves all the saved subreddits of the user.
     
     - returns: An array of subreddits.
    */
    static func getSavedSubreddits() -> [Subreddit] {
        let realm = try! Realm()
        let results = realm.objects(Subreddit.self)
        
        return Array(results)
    }
    
    /**
     Removes an specific subreddit from the list.
     
     - parameter subreddit: The subreddit to remove.
    */
    static func removeSubreddit(_ subreddit: Subreddit) {
        let realm = try! Realm()
        
        try! realm.write {
            realm.delete(subreddit)
        }
    }
    
    /**
     Returns an specific Subreddit by its name.
     
     - parameter name: Name of the subreddit to obtain.
     
     - returns: Object `Results` containing the results of the query.
    */
    static func getSubredditBy(name: String) -> Results<Subreddit> {
        let realm = try! Realm()
        
        return realm.objects(Subreddit.self).filter("name = '%@'", name)
    }
    
    /**
     Saves the specified Subreddit instance to the database.
     
     - parameter name: Name of the subreddit to add.
     - parameter time: Time from which we want to filter the posts.
    */
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
