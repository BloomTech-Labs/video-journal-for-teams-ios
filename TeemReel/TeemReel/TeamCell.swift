//
//  TeamCell.swift
//  TeemReel
//
//  Created by scott harris on 5/21/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import UIKit

class TeamCell: UICollectionViewCell {
    let parentView = UIView()
    let imageView = UIImageView()
    let nameLabel = UILabel()
    let detailLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        configureParentView()
        configureImageView()
        configureNameLabel()
        configureDetailLabel()
    }
    
    private func configureParentView() {
        contentView.addSubview(parentView)
        parentView.layer.borderColor = UIColor.quaternaryLabel.cgColor
        parentView.layer.borderWidth = 0.8
        parentView.layer.cornerRadius = 8
        parentView.translatesAutoresizingMaskIntoConstraints = false
        parentView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        parentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        parentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        parentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    private func configureImageView() {
        imageView.image = UIImage(named: "Userpic")
        parentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: parentView.topAnchor, constant: 8).isActive = true
        imageView.widthAnchor.constraint(equalTo: parentView.widthAnchor, multiplier: 1/3).isActive = true
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: parentView.centerXAnchor).isActive = true
        imageView.layer.cornerRadius = imageView.frame.width / 2
        imageView.layer.masksToBounds = true
        
    }
    
    private func configureNameLabel() {
        parentView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = "TeamReel"
        nameLabel.font = .systemFont(ofSize: 14, weight: .medium)
        nameLabel.textColor = .label
        nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: parentView.centerXAnchor).isActive = true
        
    }
    
    private func configureDetailLabel() {
        parentView.addSubview(detailLabel)
        detailLabel.numberOfLines = 3
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        detailLabel.text = "Demo team for cool activities"
        detailLabel.font = .systemFont(ofSize: 13, weight: .light)
        detailLabel.textColor = .secondaryLabel
        detailLabel.textAlignment = .center
        detailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4).isActive = true
        detailLabel.centerXAnchor.constraint(equalTo: parentView.centerXAnchor).isActive = true
        detailLabel.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: 8).isActive = true
        detailLabel.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: -8).isActive = true
        
    }
    
}
