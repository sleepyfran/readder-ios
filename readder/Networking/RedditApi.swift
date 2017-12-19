//
//  RedditApi.swift
//  readder
//
//  Created by Fran González on 17/12/17.
//  Copyright © 2017 Fran González. All rights reserved.
//

import Alamofire

class RedditApi {
    // MARK: General headers.
    let headers = [
        "User-Agent": "spaceisstrange.io.readder"
    ]
    
    // MARK: Authentication functions.
    
    // Gets the access token needed to interact with the Reddit API. Do not modify anything here except estrictly needed,
    // all the parameters or endpoint changes should be done in its separate file (ApiParameters or ApiEndpoints).
    static func getAccessToken() -> DataRequest {
        return Alamofire.request(ACCESS_TOKEN_URL,
                                 method: .post,
                                 parameters: ACCESS_TOKEN_PARAMETERS)
    }
}
