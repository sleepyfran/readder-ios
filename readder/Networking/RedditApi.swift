//
//  RedditApi.swift
//  readder
//
//  Created by Fran González on 17/12/17.
//  Copyright © 2017 Fran González. All rights reserved.
//

import RxSwift
import RxAlamofire

class RedditApi {
    // MARK: Stuff we need to keep track of.
    static var accesToken: String?
    
    // MARK: General headers.
    static let headers = [
        "User-Agent": "spaceisstrange.io.readder:v1.0"
    ]
    
    // MARK: Authentication functions.
    
    // Gets the access token needed to interact with the Reddit API. Do not modify anything here except estrictly needed,
    // all the parameters or endpoint changes should be done in its separate file (ApiParameters or ApiEndpoints).
    static func getAccessToken() -> Observable<HTTPURLResponse> {
        var authHeaders = headers
        let credentials = "\(clientId):".data(using: String.Encoding.utf8)?.base64EncodedString()
        authHeaders["Authorization"] = "Basic \(credentials!)"
        
        return RxAlamofire.requestJSON(.post,
                                       ACCESS_TOKEN_URL,
                                       parameters: ACCESS_TOKEN_PARAMETERS,
                                       headers: authHeaders)
        .map({ (response, json) in
            // Let's the save the token for later use.
            if let dict = json as? [String: AnyObject] {
                accesToken = dict["access_token"] as? String
            }
            
            return response
        })
        .observeOn(MainScheduler.instance)
    }
}
