//
//  CustomTextField.swift
//  TeamReel
//
//  Created by Elizabeth Wingate on 6/9/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {

 override init(frame: CGRect) {
     super.init(frame: frame)
     setupTextfield()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupTextfield()
    }

    func setupTextfield() {
        layer.borderWidth = 1.0
        layer.borderColor = UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 1.0).cgColor
        layer.cornerRadius = 8.0
        layer.masksToBounds = true
    }
}
