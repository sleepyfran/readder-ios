//
//  RedditApi.swift
//  readder
//
//  Created by Fran González on 17/12/17.
//  Copyright © 2017 Fran González. All rights reserved.
//

import RxSwift
import RxAlamofire
import SwiftyJSON

class RedditApi {
    // MARK: Stuff we need to keep track of.
    private static var accesToken: String?
    
    // MARK: General headers.
    static let headers = [
        "User-Agent": "spaceisstrange.io.readder:v1.0"
    ]
    
    // MARK: Authentication functions.
    
    // Gets the access token needed to interact with the Reddit API. Do not modify anything here except estrictly needed,
    // all the parameters or endpoint changes should be done in its separate file (ApiParameters or ApiEndpoints).
    static func getAccessToken() -> Observable<HTTPURLResponse> {
        let authHeaders = basicAuthHeaders(of: headers)
        
        return RxAlamofire.requestJSON(.post,
                                       ACCESS_TOKEN_URL,
                                       parameters: ACCESS_TOKEN_PARAMETERS,
                                       headers: authHeaders)
        .map({ (response, data) in
            let json = JSON(data)
            
            // Let's the save the token for later use.
            accesToken = json["access_token"].string
            
            return response
        })
        .observeOn(MainScheduler.instance)
    }
    
    // MARK: Subreddit functions.
    
    // Returns a given number of stories from the specified subreddit in the specified time (day, week, month, etc.).
    static func getStories(from subreddit: String, time: String, max: Int = 20) -> Observable<[Story]> {
        let bearerHeaders = bearerAuthHeaders(of: headers, accessToken: accesToken!)
        
        return RxAlamofire.requestJSON(.get,
                                       subredditEndpoint(subreddit, time: time, limit: max),
                                       headers: bearerHeaders)
        .map({ (response, data) in
            let json = JSON(data)
            var stories: [Story] = []
            
            // Iterate through all the posts turning them into stories.
            for (_, post):(String, JSON) in json["data"]["children"] {
                let postData = post["data"]
                let title = postData["title"].string
                let content = postData["selftext"].string
                
                let story = Story(title: title!, content: content!)
                stories.append(story)
            }
            
            return stories
        })
        .observeOn(MainScheduler.instance)
    }
}
