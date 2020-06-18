//
//  Video.swift
//  TeamReel
//
//  Created by scott harris on 6/17/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import Foundation

struct Video: Codable {
    let id: Int
    let ownerId: Int?
    let title: String
    let description: String
    let createdAt: String
    let videoURL: String
    let promptId: Int
    let organizationId: Int?
    let userName: String?
    let feedback: [VideoFeedback]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case ownerId = "owner_id"
        case title
        case description
        case createdAt = "created_at"
        case videoURL = "video_url"
        case promptId = "prompt_id"
        case organizationId = "organization_id"
        case userName = "user_full_name"
        case feedback
    }
    
}
