//
//  Prompt.swift
//  TeemReel
//
//  Created by scott harris on 5/21/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import Foundation

struct Prompt: Codable {
    let id: Int
    let question: String
    let description: String
    let teamId: Int
    let createdAt: Date
    let updatedAt: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case question
        case description
        case teamId = "team_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
