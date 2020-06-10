//
//  CustomButton.swift
//  TeamReel
//
//  Created by Elizabeth Wingate on 6/9/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    func setupButton() {
        layer.cornerRadius = 8.0
    }
}
