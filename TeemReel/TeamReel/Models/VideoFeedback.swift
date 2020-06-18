//
//  VideoFeedback.swift
//  TeamReel
//
//  Created by scott harris on 6/18/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import Foundation

struct VideoFeedback: Codable {
    let id: Int
    let post: String
    let videoId: Int
    let ownerId: Int
    let createdAt: String
    let updatedAt: String
    let viewed: Bool
    let overallPerformance: Int
    let deliveryAndPresentation: Int
    let responseQuality: Int
    let audioQuality: Int
    let visualEnvironment: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case post
        case videoId = "video_id"
        case ownerId = "owner_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case viewed
        case overallPerformance = "overall_performance"
        case deliveryAndPresentation = "delivery_and_presentation"
        case responseQuality = "response_quality"
        case audioQuality = "audio_quality"
        case visualEnvironment = "visual_environment"
    }
}
