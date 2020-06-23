//
//  TeamController.swift
//  TeamReel
//
//  Created by scott harris on 6/23/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import Foundation

class TeamController {
    let apiClient = ApiClient()
    var teams: [Team] = []
    
    func fetchTeams(for userId: Int, authToken: String, completion: @escaping () -> Void) {
        apiClient.fetchTeams(for: userId, token: authToken) { (teams, error) in
            if let error = error {
                print(error)
                completion()
                return
            }

            if let teams = teams {
                self.teams = teams
                completion()
            }
        
        }
    }
    
}
