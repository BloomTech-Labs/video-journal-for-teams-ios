//
//  Team.swift
//  TeemReel
//
//  Created by scott harris on 5/18/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import Foundation

struct Team: Codable, Equatable {
    let id: Int
    let name: String
    let description: String
    let createdAt: String
    let updatedAt: String
    let avatar: String?
    let organizationId: Int
    let teamType: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case avatar
        case organizationId = "organization_id"
        case teamType = "team_type"
    }
    
    static func ==(lhs: Team, rhs: Team) -> Bool {
        return lhs.id == rhs.id
    }
    
}
