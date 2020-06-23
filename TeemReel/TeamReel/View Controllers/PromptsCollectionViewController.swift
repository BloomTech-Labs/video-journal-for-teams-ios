//
//  PromptsCollectionViewController.swift
//  TeemReel
//
//  Created by scott harris on 5/22/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import UIKit
import AVFoundation

class PromptsCollectionViewController: UIViewController {
    var apiController: APIController?
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    var prompts: [Prompt] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(PromptCell.self, forCellWithReuseIdentifier: "PromptCell")
        
        setupViews()
    }
    
    private func setupViews() {
        setupCollectionView()
        
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        
        collectionView.backgroundColor = .systemBackground
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.estimatedItemSize = CGSize(width: view.bounds.width - 16, height: 150)
            layout.itemSize = UICollectionViewFlowLayout.automaticSize
            
        }
        
    }
}

extension PromptsCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return prompts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PromptCell", for: indexPath) as? PromptCell else { return UICollectionViewCell() }
        
        cell.prompt = prompts[indexPath.item]
        cell.delegate = self
        
        return cell
    }
}

extension PromptsCollectionViewController: UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = view.bounds.width - 16
//        let height = 50.0
//        let size = CGSize(width: Double(width), height: height)
//        return size
//    }
}

extension PromptsCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
}

extension PromptsCollectionViewController: ResondButtonTapped {
    func respondTapped(for prompt: Prompt) {
        requestPermissionAndShowCamera(for: prompt)
    }
    
    private func requestPermissionAndShowCamera(for Prompt: Prompt) {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        
        switch status {
        case .notDetermined: // first run user hasnt been asked to give permission
            requestPermission(with: Prompt)
        case .restricted: // parental controls limits access to video
            fatalError("You dont have permission to use the camera, talk to your gardian")
        case .denied: // 2nd+ run,m the user didnt trust us or said no by accident(show how to enable)
            fatalError("Show them a link to settings to get access to video")
        case .authorized: // 2nd+ run, theyve given permission to use the camera
            showCamera(with: Prompt)
        @unknown default:
            fatalError("Didn't handle a new state for AVCaptureDevice authorization")
        }
    }
    
    private func requestPermission(with prompt: Prompt) {
        AVCaptureDevice.requestAccess(for: .video) { (granted) in
            guard granted else {
                fatalError("Tell user the need to give video permission")
            }
            
            DispatchQueue.main.async {
                self.showCamera(with: prompt)
            }
            
        }
    }
    
    private func showCamera(with prompt: Prompt) {
        let cameraVC = CameraViewController()
        cameraVC.modalPresentationStyle = .fullScreen
        cameraVC.apiController = apiController
        cameraVC.prompt = prompt
        present(cameraVC, animated: true)
    }
    
    
}
