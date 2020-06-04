//
//  VideoResponseViewController.swift
//  TeemReel
//
//  Created by scott harris on 6/4/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import UIKit
import AVFoundation

class VideoReponseViewController: UIViewController {
    
    let playerView = UIView()
    let respondButton = UIButton(type: .roundedRect)
    var bearer: Bearer?
    var promptId: Int?
    var videoURL: URL? {
        didSet {
            DispatchQueue.main.async {
                self.updateViews()
                
            }
        }
    }
    var player: AVPlayer?
    var playerLayer: AVPlayerLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        setupPlayerView()
        setupRespondButton()
    }
    
    private func setupPlayerView() {
        view.addSubview(playerView)
        playerView.translatesAutoresizingMaskIntoConstraints = false
        playerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        playerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        playerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        playerView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 4/3).isActive = true
        
        playerView.layoutIfNeeded()
        
        playerView.backgroundColor = .black
        
    }
    
    private func updateViews() {
        if let url = videoURL {
            player = AVPlayer(url: url)
            playerLayer = AVPlayerLayer(player: player)
            playerView.layer.addSublayer(playerLayer!)
            playerLayer?.videoGravity = .resizeAspectFill
            playerLayer!.frame = playerView.bounds
            player?.play()
            
        }
    }
    
    private func setupRespondButton() {
        view.addSubview(respondButton)
        respondButton.translatesAutoresizingMaskIntoConstraints = false
        respondButton.addTarget(self, action: #selector(respondTapped), for: .touchUpInside)
        respondButton.setTitle("Respond", for: .normal)
        respondButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        respondButton.setTitleColor(.white, for: .normal)
        respondButton.backgroundColor = UIColor(named: "App-Purple")
        respondButton.layer.cornerRadius = 8
        respondButton.topAnchor.constraint(equalTo: playerView.bottomAnchor, constant: 16).isActive = true
        respondButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36).isActive = true
        respondButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -36).isActive = true
        respondButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    @objc private func respondTapped() {
        guard let bearer = bearer, let promptId = promptId, let videoURL = videoURL else { return }
        
        let postVC = PostVideoViewController()
        postVC.userId = bearer.user.id
        postVC.promptId = promptId
        postVC.videoURL = videoURL
        postVC.token = bearer.token
        
        navigationController?.pushViewController(postVC, animated: true)
        
    }
}
