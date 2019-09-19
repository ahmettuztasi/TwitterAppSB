//
//  Tweet.swift
//  TwitterAppSB
//
//  Created by KO on 17/09/2019.
//  Copyright © 2019 Ahmet Tuztașı. All rights reserved.
//

import Foundation

class Tweet:  Decodable {
    
    //MARK: Properties
    
    let userId: Int
    let id: Int
    let firstName: String
    let lastName: String
    let profile: String
    let profileImgUrl: String
    let tweetText: String
    
    
    //MARK: Initialization
    
    init(userId: Int, id: Int, firstName: String, lastName: String, profile: String, profileImgUrl: String, tweetText: String) {
        
        // Initialize stored properties.
        self.userId = userId
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.profile = profile
        self.profileImgUrl = profileImgUrl
        self.tweetText = tweetText
    }
}
