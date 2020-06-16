//
//  TeamHeaderView.swift
//  TeamReel
//
//  Created by scott harris on 6/16/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import UIKit

class TeamHeaderView: UIView {
    
    let nameLabel = UILabel()
    
    var team: Team? {
        didSet {
            updateViews()
        }
    }
    var images: [UIImageView] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        setupNameLabel()
        generateImages()
    }
    
    private func setupNameLabel() {
        addSubview(nameLabel)
        nameLabel.text = "team.name"
        nameLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 24).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        nameLabel.trailingAnchor.constraint(greaterThanOrEqualTo: trailingAnchor).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
    }
    
    private func generateImages() {
        for i in 1...5 {
            if i == 1 {
                let imageView = CustomCirclePictures(frame: .zero)
                imageView.image = UIImage(named: "mugshot\(i)")
                images.append(imageView)
                addSubview(imageView)
                imageView.translatesAutoresizingMaskIntoConstraints = false
                imageView.topAnchor.constraint(equalTo: topAnchor, constant: 60).isActive = true
                imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
                imageView.widthAnchor.constraint(equalToConstant: 65).isActive = true
                imageView.heightAnchor.constraint(equalToConstant: 65).isActive = true
                layoutIfNeeded()
                imageView.circularImage()
            } else {
                let imageView = CustomCirclePictures(frame: .zero)
                imageView.image = UIImage(named: "mugshot\(i)")
                images.append(imageView)
                addSubview(imageView)
                imageView.translatesAutoresizingMaskIntoConstraints = false
                imageView.topAnchor.constraint(equalTo: topAnchor, constant: 60).isActive = true
                imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CGFloat(40 * i - 16)).isActive = true
                imageView.widthAnchor.constraint(equalToConstant: 65).isActive = true
                imageView.heightAnchor.constraint(equalToConstant: 65).isActive = true
                layoutIfNeeded()
                imageView.circularImage()
            }
        }
    }
    
    private func updateViews() {
        guard let team = team else { return }
        nameLabel.text = team.name
    }
}
