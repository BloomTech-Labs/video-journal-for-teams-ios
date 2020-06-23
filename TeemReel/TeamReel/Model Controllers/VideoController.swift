//
//  VideoController.swift
//  TeamReel
//
//  Created by scott harris on 6/23/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import Foundation

class VideosController {
    let apiClient = ApiClient()
    var videos: [Video] = []
    
    func fetchVideos(for userId: Int, token: String, completion: @escaping () -> Void) {
        apiClient.fetchUsersVideos(for: userId, token: token) { (videos, error) in
            if let error = error {
                print(error)
                completion()
                return
            }
            
            if let videos = videos {
                self.videos = videos
                completion()
            }
        }
    }
    
}
