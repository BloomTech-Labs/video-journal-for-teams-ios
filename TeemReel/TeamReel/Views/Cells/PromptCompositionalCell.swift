//
//  PromptCompositionalCell.swift
//  TeemReel
//
//  Created by scott harris on 5/22/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import UIKit

class PromptCompositionalCell: UICollectionViewCell {
    
    var prompt: Prompt? {
        didSet {
            updateViews()
        }
    }
    
    var team: Team? {
        didSet {
            updateViews()
        }
    }
    
    
    var container: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var iconView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray3
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var iconLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "TR"
        label.textColor = .white
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var teamNameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "App Title"
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var questionLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "Sport"
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(self.container)
        self.container.addSubview(self.iconView)
        self.container.addSubview(self.teamNameLabel)
        self.container.addSubview(self.questionLabel)
        self.iconView.addSubview(iconLabel)
        
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
            self.iconView.heightAnchor.constraint(equalToConstant: 40),
        ])
        
        NSLayoutConstraint.activate([
            self.iconLabel.centerYAnchor.constraint(equalTo: iconView.centerYAnchor),
            self.iconLabel.centerXAnchor.constraint(equalTo: iconView.centerXAnchor)

        ])
        
        NSLayoutConstraint.activate([
            self.teamNameLabel.topAnchor.constraint(equalTo: self.container.topAnchor, constant: 8),
            self.teamNameLabel.leftAnchor.constraint(equalTo: self.iconView.rightAnchor, constant: 10),
            self.teamNameLabel.rightAnchor.constraint(equalTo: self.container.rightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            self.questionLabel.topAnchor.constraint(equalTo: self.teamNameLabel.bottomAnchor, constant: 0),
            self.questionLabel.leftAnchor.constraint(equalTo: self.iconView.rightAnchor, constant: 10),
            self.questionLabel.rightAnchor.constraint(equalTo: self.container.rightAnchor),
        ])
        layoutIfNeeded()
        updateViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateViews() {
        iconView.layer.cornerRadius = iconView.frame.width / 2
        guard let prompt = prompt, let team = team else { return }
        let initials = Utilities.generateInitials(for: team.name)
        iconLabel.text = initials
        teamNameLabel.text = team.name
        questionLabel.text = prompt.question
        
    }
    
}
