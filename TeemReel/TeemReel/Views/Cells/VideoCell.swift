//
//  VideoCell.swift
//  TeemReel
//
//  Created by scott harris on 5/27/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import UIKit

class VideoCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.backgroundColor = .systemFill
        self.contentView.layer.cornerRadius = 8
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
