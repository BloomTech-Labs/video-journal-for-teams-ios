//
//  User.swift
//  TeemReel
//
//  Created by Elizabeth Wingate on 5/14/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import Foundation

struct User: Codable {
    
    let username: String
    let password: String?
    let firstName: String
    let lastName: String
    let email: String
    let id: Int?
    
    enum CodingKeys: String, CodingKey {
        case username
        case password
        case firstName = "first_name"
        case lastName = "last_name"
        case email
        case id
    
    }
}
