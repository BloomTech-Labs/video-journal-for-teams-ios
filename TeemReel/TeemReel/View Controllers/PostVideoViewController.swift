//
//  PostVideoViewController.swift
//  TeemReel
//
//  Created by scott harris on 6/4/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import UIKit

class PostVideoViewController: UIViewController {
    let apiClient = ApiClient()
    let titleTextField = UITextField()
    let descriptionTextField = UITextField()
    var videoURL: URL?
    var userId: Int?
    var promptId: Int?
    var token: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(titleTextField)
        view.addSubview(descriptionTextField)
        titleTextField.placeholder = "Title"
        descriptionTextField.placeholder = "Video Description"
        
        titleTextField.tintColor = UIColor.lightGray
        descriptionTextField.tintColor = UIColor.lightGray
        
        titleTextField.layer.borderWidth = 1.0
        titleTextField.layer.borderColor = UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 1.0).cgColor
        titleTextField.layer.cornerRadius = 8.0
        titleTextField.layer.masksToBounds = true
        
        descriptionTextField.layer.borderWidth = 1.0
        descriptionTextField.layer.borderColor = UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 1.0).cgColor
        descriptionTextField.layer.cornerRadius = 8.0
        descriptionTextField.layer.masksToBounds = true
        
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextField.translatesAutoresizingMaskIntoConstraints = false
        titleTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40).isActive = true
        titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true
        titleTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        descriptionTextField.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 16).isActive = true
        descriptionTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        descriptionTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true
        descriptionTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let rightBarButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTapped))
        navigationItem.rightBarButtonItem = rightBarButton
        
    }
    
    @objc func saveTapped() {
        guard let titleText = titleTextField.text, !titleText.isEmpty, let descriptionText = descriptionTextField.text, !descriptionText.isEmpty, let videoURL = videoURL, let userId = userId, let promptId = promptId, let token = token else { return }
        
        apiClient.uploadVideoResponse(title: titleText, description: descriptionText, userId: userId, promptId: promptId, videoFileURL: videoURL, token: token) { (error) in
            if let error =  error {
                print("Error uploading video: \(error)")
                
            }
            DispatchQueue.main.async {
                self.navigationController?.popToRootViewController(animated: true)
                
            }
        }
        
    }
}
