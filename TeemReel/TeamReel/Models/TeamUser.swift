//
//  TeamUser.swift
//  TeamReel
//
//  Created by scott harris on 6/17/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import Foundation

struct TeamUser: Codable {
    let teamName: String
    let roleId: Int
    let avatarURL: String
    let userId: Int
    let email: String
    let fullName: String
    
    enum CodingKeys: String, CodingKey {
        case teamName = "team_name"
        case roleId = "role_id"
        case avatarURL = "avatar"
        case userId = "user_id"
        case email
        case fullName = "user_full_name"
    }
    
}
