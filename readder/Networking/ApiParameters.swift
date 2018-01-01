//
//  ApiParameters.swift
//  readder
//
//  Created by Fran González on 19/12/17.
//  Copyright © 2017 Fran González. All rights reserved.
//

import Foundation

// MARK: Access token

// Initialized in the AppDelegate with the loaded client_id from the Keys.plist file.
var clientId = ""

// Parameters needed in the access token petition.
let ACCESS_TOKEN_PARAMETERS = [
    "grant_type": "https://oauth.reddit.com/grants/installed_client",
    "user": clientId,
    "device_id": UUID().uuidString,
]
