//
//  VideoPlayerViewController.swift
//  TeamReel
//
//  Created by scott harris on 6/18/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import UIKit
import AVFoundation

class VideoPlayerViewController: UIViewController {
    let playerView = UIView()
    var videoURL: URL? {
        didSet {
            updateViews()
        }
    }
    var player: AVPlayer?
    var playerLayer: AVPlayerLayer?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        updateViews()
    }
    
    private func setupViews() {
        setupPlayerView()
        
    }
    
    private func setupPlayerView() {
        view.addSubview(playerView)
        playerView.translatesAutoresizingMaskIntoConstraints = false
        playerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        playerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        playerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        playerView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        
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
    
}
