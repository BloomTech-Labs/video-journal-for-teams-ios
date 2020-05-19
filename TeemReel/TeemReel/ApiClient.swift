//
//  ApiClient.swift
//  TeemReel
//
//  Created by scott harris on 5/15/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import Foundation


class ApiClient {
    let baseURL = URL(string: "https://video-journal.herokuapp.com/api/")!
    
    func fetchOrganizations(userId: Int, completion: @escaping ([Organization]?, Error?) -> Void) {
        let urlPath = baseURL.appendingPathComponent("users/\(userId)/organizations")
        
        var urlRequest = URLRequest(url: urlPath)
        urlRequest.addValue("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjE5NywiaWF0IjoxNTg5OTA5NTcxLCJleHAiOjE1ODk5NTI3NzF9.6xuFZS7Hx7-ndRGEIc9Etlc4Ywt8RPfPqrcv-HUe0OY", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Network Error: \(error)")
                completion(nil, error)
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                let error = NSError(domain: "com.teamreel", code: 101, userInfo: nil)
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "com.teamreel", code: 105, userInfo: nil)
                completion(nil, error)
                return
            }
            
            do {
                let orgs = try JSONDecoder().decode([Organization].self, from: data)
                completion(orgs, nil)
                return
            } catch {
                completion(nil, error)
                return
            }
            
        }.resume()
        
    }
    
    func fetchTeams(for organizationId: Int, completion: @escaping ([Team]?, Error?) -> Void) {
        let urlPath = baseURL.appendingPathComponent("organizations/\(organizationId)/teams")
        
        var urlRequest = URLRequest(url: urlPath)
        urlRequest.addValue("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjE5NywiaWF0IjoxNTg5OTA5NTcxLCJleHAiOjE1ODk5NTI3NzF9.6xuFZS7Hx7-ndRGEIc9Etlc4Ywt8RPfPqrcv-HUe0OY", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Network Error: \(error)")
                completion(nil, error)
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                let error = NSError(domain: "com.teamreel", code: 101, userInfo: nil)
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "com.teamreel", code: 105, userInfo: nil)
                completion(nil, error)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let teams = try decoder.decode([Team].self, from: data)
                completion(teams, nil)
                return
            } catch {
                completion(nil, error)
                return
            }
            
        }.resume()
        
    }
    
}
