//
//  PromptCell.swift
//  TeemReel
//
//  Created by scott harris on 5/22/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import UIKit

class PromptCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
