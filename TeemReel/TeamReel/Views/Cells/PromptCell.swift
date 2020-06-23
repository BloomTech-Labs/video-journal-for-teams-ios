//
//  PromptCell.swift
//  TeamReel
//
//  Created by scott harris on 6/11/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import UIKit
import AVFoundation

protocol ResondButtonTapped {
    func respondTapped(for prompt: Prompt)
}

class PromptCell: UICollectionViewCell {
    let containerView = UIView()
    let titleLabel = UILabel()
    let questionLabel = UILabel()
    let respondButton = UIButton(type: .roundedRect)
    var apiController: APIController?
    var delegate: ResondButtonTapped?
    
    var prompt: Prompt? {
        didSet {
            updateViews()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateViews() {
        if let prompt = prompt {
            titleLabel.text = prompt.question
            questionLabel.text = prompt.description
        }
    }
    
    private func setupViews() {
        setupContainerView()
        setupTitleLabel()
        setupQuestionLabel()
        setupRepondButton()
        updateViews()
    }
    
    private func setupContainerView() {
        addSubview(containerView)
        containerView.layer.borderColor = UIColor.lightGray.cgColor
        containerView.layer.borderWidth = 0.5
        containerView.layer.cornerRadius = 8
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
//        containerView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width - 16).isActive = true
    }
    
    private func setupTitleLabel() {
        containerView.addSubview(titleLabel)
        titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20).isActive = true
        
        
    }
    
    private func setupQuestionLabel() {
        containerView.addSubview(questionLabel)
        questionLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        questionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16).isActive = true
        questionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20).isActive = true
        questionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20).isActive = true
    }
    
    private func setupRepondButton() {
        containerView.addSubview(respondButton)
        // TODO: - add protocol delegate!!
        respondButton.addTarget(self, action: #selector(respondTapped), for: .touchUpInside)
        respondButton.setTitle("Respond", for: .normal)
        respondButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        respondButton.setTitleColor(.white, for: .normal)
        respondButton.backgroundColor = UIColor(named: "App-Purple")
        respondButton.layer.cornerRadius = 8
        respondButton.translatesAutoresizingMaskIntoConstraints = false
        respondButton.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 16).isActive = true
        respondButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8).isActive = true
        respondButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8).isActive = true
        respondButton.widthAnchor.constraint(equalToConstant: 163).isActive = true
        respondButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let autoLayoutAttributes = super.preferredLayoutAttributesFitting(layoutAttributes)

        // Specify you want _full width_
        let targetSize = CGSize(width: layoutAttributes.frame.width - 16, height: 0)

        // Calculate the size (height) using Auto Layout
        let autoLayoutSize = contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: UILayoutPriority.required, verticalFittingPriority: UILayoutPriority.defaultLow)
        let autoLayoutFrame = CGRect(origin: autoLayoutAttributes.frame.origin, size: autoLayoutSize)

        // Assign the new size to the layout attributes
        autoLayoutAttributes.frame = autoLayoutFrame
        return autoLayoutAttributes
    }
    
    @objc private func respondTapped() {
        if let prompt = prompt {
            delegate?.respondTapped(for: prompt)
        }
        
    }
}
