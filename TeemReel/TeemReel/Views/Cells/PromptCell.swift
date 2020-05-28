//
//  PromptCell.swift
//  TeemReel
//
//  Created by scott harris on 5/22/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import UIKit

class PromptCell: UICollectionViewCell {
    var container: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var iconView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.cornerRadius = 5
        view.layer.shadowOpacity = 0.3
        view.layer.shadowRadius = 2
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var appTitle: UILabel = {
        let label: UILabel = UILabel()
        label.text = "App Title"
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var appCategory: UILabel = {
        let label: UILabel = UILabel()
        label.text = "Sport"
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(self.container)
        self.container.addSubview(self.iconView)
        self.container.addSubview(self.appTitle)
        self.container.addSubview(self.appCategory)
        
        let bottomBorder = UIView(frame: CGRect(x: 4, y: self.frame.size.height - 1, width: self.frame.size.width - 4, height: 1))
        bottomBorder.backgroundColor = .secondarySystemFill
        self.contentView.addSubview(bottomBorder)
        
        
        NSLayoutConstraint.activate([
            self.container.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.container.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            self.container.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            self.container.rightAnchor.constraint(equalTo: self.contentView.rightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            self.iconView.topAnchor.constraint(equalTo: self.container.topAnchor, constant: 10),
            self.iconView.leftAnchor.constraint(equalTo: self.container.leftAnchor, constant: 10),
            self.iconView.widthAnchor.constraint(equalToConstant: 40),
            self.iconView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            self.appTitle.topAnchor.constraint(equalTo: self.container.topAnchor, constant: 8),
            self.appTitle.leftAnchor.constraint(equalTo: self.iconView.rightAnchor, constant: 10),
            self.appTitle.rightAnchor.constraint(equalTo: self.container.rightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            self.appCategory.topAnchor.constraint(equalTo: self.appTitle.bottomAnchor, constant: 0),
            self.appCategory.leftAnchor.constraint(equalTo: self.iconView.rightAnchor, constant: 10),
            self.appCategory.rightAnchor.constraint(equalTo: self.container.rightAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
