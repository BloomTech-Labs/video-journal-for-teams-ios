//
//  PromptResponseViewController.swift
//  TeamReel
//
//  Created by scott harris on 6/18/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import UIKit

class PromptResponseViewController: UIViewController {
    var video: Video?
    var videoURL: URL?
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    let playerVC = VideoPlayerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray
        setupPlayerController()
        setupTableView()
    }
    
    private func setupPlayerController() {
//        let playerVC = VideoPlayerViewController()
        addChild(playerVC)
        view.addSubview(playerVC.view)
        playerVC.didMove(toParent: self)
        
        playerVC.view.translatesAutoresizingMaskIntoConstraints = false
        playerVC.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        playerVC.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        playerVC.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        playerVC.view.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 3 / 4).isActive = true
        playerVC.view.layoutIfNeeded()
        playerVC.videoURL = videoURL
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "FeedbackCell")
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: playerVC.view.bottomAnchor, constant: 0).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
}

extension PromptResponseViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return video?.feedback?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedbackCell", for: indexPath)
        if let feedback = video?.feedback?[indexPath.row] {
            cell.textLabel?.text = feedback.post
        }
        
        return cell
    }
}
