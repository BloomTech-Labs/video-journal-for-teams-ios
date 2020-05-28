//
//  Utilities.swift
//  TeemReel
//
//  Created by Elizabeth Wingate on 5/14/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import Foundation
import UIKit

class Utilities {

    static func isPasswordValid(_ password : String) -> Bool {
     
     let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
     return passwordTest.evaluate(with: password)
  }
}
