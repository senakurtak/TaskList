//
//  Oauth.swift
//  BauBuddyTaskList
//
//  Created by Sena Kurtak on 14.02.2023.
//

import Foundation

class Oauth: Codable {
    
    var access_token : String?
    var refresh_token : String?

    init(access_token: String? = nil, refresh_token: String? = nil) {
    
        self.access_token = access_token
        self.refresh_token = refresh_token
        
    }
}
