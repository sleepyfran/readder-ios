//
//  ApiEndpoints.swift
//  readder
//
//  Created by Fran González on 17/12/17.
//  Copyright © 2017 Fran González. All rights reserved.
//

// MARK: Access Token and Base URLs
let ACCESS_TOKEN_URL = "https://www.reddit.com/api/v1/access_token"
let BASE_URL = "https://oauth.reddit.com"

// MARK: Endpoints

/**
 Creates the endpoint needed to obtain posts from a subreddit.
 
 - parameter subreddit: Subreddit from where to obtain the stories.
 - parameter time: Time of the posts to filter (day, week, month...)
 - parameter max: Maximum number of posts to get.
 
 - returns: A String containing the whole URL of the endpoint.
*/
func subredditEndpoint(_ subreddit: String, time: String, limit: Int) -> String {
    return "\(BASE_URL)/r/\(subreddit)/top.json?t=\(time)&limit=\(limit)"
}
