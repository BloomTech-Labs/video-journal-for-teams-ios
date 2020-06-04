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
    
    func fetchOrganizations(userId: Int, token: String, completion: @escaping ([Organization]?, Error?) -> Void) {
        let urlPath = baseURL.appendingPathComponent("users/\(userId)/organizations")
        
        var urlRequest = URLRequest(url: urlPath)
        urlRequest.addValue(token, forHTTPHeaderField: "Authorization")
        
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
    
    func fetchTeams(for userId: Int, organizationId: Int, token: String, completion: @escaping ([Team]?, Error?) -> Void) {
        let urlPath = baseURL.appendingPathComponent("users/\(userId)/teams/\(organizationId)")
        
        var urlRequest = URLRequest(url: urlPath)
        urlRequest.addValue(token, forHTTPHeaderField: "Authorization")
        
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
    
    func fetchPrompts(for teamId: Int, token: String, completion: @escaping ([Prompt]?, Error?) -> Void) {
        let urlPath = baseURL.appendingPathComponent("teams/\(teamId)/prompts")
        
        var urlRequest = URLRequest(url: urlPath)
        urlRequest.addValue(token, forHTTPHeaderField: "Authorization")
        
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
                let prompts = try decoder.decode([Prompt].self, from: data)
                completion(prompts, nil)
                return
            } catch {
                completion(nil, error)
                return
            }
            
        }.resume()
        
    }
    
    func uploadVideoResponse(title: String, description: String, userId: Int, promptId: Int, videoFileURL: URL, token: String, completion: @escaping (Error?) -> Void) {
        
        let urlPath = baseURL.appendingPathComponent("videos")
        
        var request = URLRequest(url: urlPath)
        request.httpMethod = "POST"
        request.addValue(token, forHTTPHeaderField: "Authorization")
        
        let userIdString = String(userId)
        let prompIdString = String(promptId)
        
        let dict = ["title": title, "description": description, "owner_id": userIdString, "prompt_id": prompIdString]
        
        let body = NSMutableData()
        let boundary = UUID().uuidString
        let contentType = "multipart/form-data; boundary=\(boundary)"
        let mimetype = "video/mp4"
        request.addValue(contentType, forHTTPHeaderField: "Content-Type")
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"video\"; filename=\"\(UUID().uuidString).mp4\"\r\n".data(using:.utf8)!)
        body.append("Content-Type: \(mimetype)\r\n\r\n".data(using: String.Encoding.utf8)!)
        
        do {
            let vidData = try Data(contentsOf: videoFileURL)
            body.append(vidData)
            body.append("\r\n".data(using: String.Encoding.utf8)!)
        } catch {
            print("json encoding error: \(error)")
            completion(error)
            return
        }
        
        for (key, _) in dict {
            if let anEncoding = "--\(boundary)\r\n".data(using: .utf8) {
                body.append(anEncoding)
            }
            if let anEncoding = "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8) {
                body.append(anEncoding)
            }
            if let aKey = dict[key], let anEncoding = "\(aKey)".data(using: .utf8) {
                body.append(anEncoding)
            }
            if let anEncoding = "\r\n".data(using: .utf8) {
                body.append(anEncoding)
            }
        }
        
        body.append("--\(boundary)--\r\n".data(using: String.Encoding.utf8)!)

        
        request.httpBody = body as Data
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Video upload network error: \(error)")
                completion(error)
                return
            }
            
            if let response = response as? HTTPURLResponse {
                print("the response from upload was: \(response.statusCode)")
                
            }
            
            completion(nil)
        }.resume()
    }
    
}
