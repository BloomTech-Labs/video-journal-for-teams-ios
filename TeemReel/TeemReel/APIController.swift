//
//  APIController.swift
//  TeemReel
//
//  Created by Elizabeth Wingate on 5/14/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import Foundation
import UIKit

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

enum NetworkError: Error {
    case noData
    case failedSignUp
}

enum HTTPHeaderValue: String {
    case json = "application/json"
}

enum HTTPHeaderField: String {
    case contentType = "Content-Type"
}

 class APIController {
    
    var bearer: Bearer?
    
    private let baseURL = URL(string: "https://video-journal-staging.herokuapp.com/api/")!
    
    private lazy var registerURL = baseURL.appendingPathComponent("auth/register")
    private lazy var loginURL = baseURL.appendingPathComponent("auth/login/username")
    
    // sign up function
    func signUp (with user: User, completion: @escaping (Result<Bool, NetworkError>) -> Void) {
        print("registerURL = \(registerURL.absoluteString)")
        
        var request = URLRequest(url: registerURL)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let jsonData = try encoder.encode(user)
            print(String(data:jsonData,encoding: .utf8)!)
            request.httpBody = jsonData
            
            let task = URLSession.shared.downloadTask(with: request) { (_, response, error) in
                
                // checking error
                if let error = error {
                    print("Sign up failed with error: \(error)")
                    completion(.failure(.failedSignUp))
                    return
                }
                guard let response = response as? HTTPURLResponse,
                    response.statusCode == 201 else {
                        print("Sign Up was unsuccessful")
                        completion(.failure(.failedSignUp))
                        return
                }
                completion(.success(true))
            }
            task.resume()
        } catch {
            print("Error encoding user: \(error)")
            completion(.failure(.failedSignUp))
        }
    }
    
    func signIn(with username: String, password: String, completion: @escaping (Error?) -> Void) {
        var request = URLRequest(url: loginURL)
        
            request.httpMethod = HTTPMethod.post.rawValue
            request.setValue(HTTPHeaderValue.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
        let jsonEncoder = JSONEncoder()
            do {
                let obj = ["username": username, "password": password]
                let data = try jsonEncoder.encode(obj)
            request.httpBody = data
       } catch {
            NSLog("Error encoding user object \(error)")
          completion(error)
          return
        }
         print(request)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
        if let error = error {
            NSLog("Error recieved From Data Task \(error)")
          completion(error)
          return
         }
                
        if let response = response as? HTTPURLResponse,
          response.statusCode != 200 {
          completion(NSError(domain: "", code: response.statusCode, userInfo: nil))
          return
        }
                
        guard let data = data else {
          completion(NSError())
          return
        }
            
        do {
        let decoder = JSONDecoder()
        self.bearer = try decoder.decode(Bearer.self, from: data)
                    
        } catch {
      NSLog("Error decoding bearer object: \(error)")
           completion(error)
            return
        }
           completion(nil)
        }.resume()
    }
}
