//
//  PromptViewController.swift
//  TeemReel
//
//  Created by scott harris on 6/2/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import UIKit
import AVFoundation

class PromptViewController: UIViewController {
    let containerView = UIView()
    let titleLabel = UILabel()
    let questionLabel = UILabel()
    let respondButton = UIButton(type: .roundedRect)
    var apiController: APIController?
    
    var prompt: Prompt? {
        didSet {
            updateViews()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = .systemBackground
        setupViews()
    }
    
    private func updateViews() {
        if let prompt = prompt, isViewLoaded {
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
        view.addSubview(containerView)
        containerView.layer.borderColor = UIColor.lightGray.cgColor
        containerView.layer.borderWidth = 0.5
        containerView.layer.cornerRadius = 8
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
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
        respondButton.addTarget(self, action: #selector(respondTapped), for: .touchUpInside)
        respondButton.setTitle("Respond", for: .normal)
        respondButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        respondButton.setTitleColor(.white, for: .normal)
        respondButton.backgroundColor = UIColor(named: "App-Purple")
        respondButton.layer.cornerRadius = 8
        respondButton.translatesAutoresizingMaskIntoConstraints = false
        respondButton.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 16).isActive = true
        respondButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20).isActive = true
        respondButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16).isActive = true
        respondButton.widthAnchor.constraint(equalToConstant: 163).isActive = true
        respondButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    @objc private func respondTapped() {
        requestPermissionAndShowCamera()
    }
    
    private func requestPermissionAndShowCamera() {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        
        switch status {
        case .notDetermined: // first run user hasnt been asked to give permission
            requestPermission()
        case .restricted: // parental controls limits access to video
            fatalError("You dont have permission to use the camera, talk to your gardian")
        case .denied: // 2nd+ run,m the user didnt trust us or said no by accident(show how to enable)
            fatalError("Show them a link to settings to get access to video")
        case .authorized: // 2nd+ run, theyve given permission to use the camera
            showCamera()
        @unknown default:
            fatalError("Didn't handle a new state for AVCaptureDevice authorization")
        }
    }
    
    private func requestPermission() {
        AVCaptureDevice.requestAccess(for: .video) { (granted) in
            guard granted else {
                fatalError("Tell user the need to give video permission")
            }
            
            DispatchQueue.main.async {
                self.showCamera()
            }
            
        }
    }
    
    private func showCamera() {
        let cameraVC = CameraViewController()
        cameraVC.modalPresentationStyle = .fullScreen
        cameraVC.apiController = apiController
        cameraVC.prompt = prompt
        present(cameraVC, animated: true)
    }
}
