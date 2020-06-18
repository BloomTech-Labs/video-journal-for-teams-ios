//
//  Utilities.swift
//  TeemReel
//
//  Created by Elizabeth Wingate on 5/14/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class Utilities {
    
    static func isPasswordValid(_ password : String) -> Bool {
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    static func generateInitials(for string: String) -> String {
        let str = string.split(separator: " ")
        if str.count >= 2 {
            let first = str[0].first?.uppercased()
            let second = str[1].first?.uppercased()
            let initials = "\(first!)\(second!)"
            return initials
        }
        
        if str.count > 0 {
            let first = str[0].first?.uppercased()
            let initials = "\(first!)"
            return initials
        } else {
            return ""
        }
    }
    
    static func createThumbnailOfVideoFromRemoteUrl(url: String) -> UIImage? {
        let asset = AVAsset(url: URL(string: url)!)
        let assetImgGenerate = AVAssetImageGenerator(asset: asset)
        assetImgGenerate.appliesPreferredTrackTransform = true
        //Can set this to improve performance if target size is known before hand
        assetImgGenerate.maximumSize = CGSize(width: 164, height: 164)
        let time = CMTimeMakeWithSeconds(1.0, preferredTimescale: 600)
        do {
            let img = try assetImgGenerate.copyCGImage(at: time, actualTime: nil)
            let thumbnail = UIImage(cgImage: img)
            return thumbnail
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
}
