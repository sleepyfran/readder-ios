//
//  ApiCredentials.swift
//  readder
//
//  Created by Fran González on 1/1/18.
//  Copyright © 2018 Fran González. All rights reserved.
//

// Appends the basic authentication header to a given set of parameters.
func basicAuthHeaders(of headers: [String:String]) -> [String:String] {
    var authHeaders = headers
    let credentials = "\(clientId):".data(using: String.Encoding.utf8)?.base64EncodedString()
    authHeaders["Authorization"] = "Basic \(credentials!)"
    
    return authHeaders
}

// Appens the bearer authentication header to a given set of parameters.
func bearerAuthHeaders(of headers: [String:String], accessToken: String) -> [String:String] {
    var bearerHeaders = headers
    let credentials = "\(accessToken)"
    bearerHeaders["Authorization"] = "Bearer \(credentials)"
    
    return bearerHeaders
}
