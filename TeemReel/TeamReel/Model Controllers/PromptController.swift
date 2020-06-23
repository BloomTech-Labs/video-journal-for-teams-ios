//
//  PromptController.swift
//  TeamReel
//
//  Created by scott harris on 6/23/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import Foundation

class PromptController {
    let apiClient = ApiClient()
    var prompts: [Prompt] = []
    
    func fetchUsersPrompts(for userId: Int, authToken: String, completion: @escaping () -> Void) {
        apiClient.fetchUsersPrompts(for: userId, token: authToken) { (prompts, error) in
            if let error = error {
                print(error)
                completion()
                return
            }
            
            if let prompts = prompts {
                self.prompts = prompts
                completion()
            }
        }
    }
    
}
