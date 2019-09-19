//
//  User.swift
//  TwitterAppSB
//
//  Created by KO on 17/09/2019.
//  Copyright © 2019 Ahmet Tuztașı. All rights reserved.
//

import Foundation

class User:  Decodable {
    
    //MARK: Properties
    
    let id: Int
    let firstName: String
    let lastName: String
    let profile: String
    let profileImgUrl: String
    let age: Int
    
    //MARK: Initialization
    
    init(id: Int, firstName: String, lastName: String, profile: String, profileImgUrl: String, age: Int) {
        
        // Initialize stored properties.
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.profile = profile
        self.profileImgUrl = profileImgUrl
        self.age = age
    }
}
