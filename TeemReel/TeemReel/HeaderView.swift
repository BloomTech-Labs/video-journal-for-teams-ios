//
//  HeaderView.swift
//  TeemReel
//
//  Created by scott harris on 5/27/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import UIKit

class HeaderView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHeaderView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    let titleLabel = UILabel()
    var type = "Your Teams" {
        didSet {
            setupHeaderView()
        }
    }
    
    private func setupHeaderView() {
        
        titleLabel.text = "\(type)"
        titleLabel.textColor = .label
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        
        let viewAllButton = UIButton()
        let attr = NSAttributedString(string: "View All", attributes: [NSAttributedString.Key.foregroundColor: UIColor.link, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13, weight: .light)])
        
        let chev = NSAttributedString(string: " >", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray   , NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .semibold)])
        let mut = NSMutableAttributedString(attributedString: attr)
        mut.append(chev)
        
        viewAllButton.setAttributedTitle(mut, for: .normal)
        
        addSubview(titleLabel)
        addSubview(viewAllButton)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        viewAllButton.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: viewAllButton.leadingAnchor, constant: 8).isActive = true
        
//        titleLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        viewAllButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        viewAllButton.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        
        
    }
}
