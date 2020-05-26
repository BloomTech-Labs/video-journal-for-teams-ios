//
//  PromptsTableViewController.swift
//  TeemReel
//
//  Created by scott harris on 5/22/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import UIKit

class PromptsTableViewController: UIViewController {
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    let promptLabel = UILabel()
//    var temp = [1,2,3,4,5,6,7,8,9]
    
    let temp = [["Team": "Team Reel", "Prompt": "Why starting a fire is bad"],
        ["Team": "Team Reel", "Prompt": "Why starting a fire is bad"],
        ["Team": "Team Reel", "Prompt": "Why starting a fire is bad"],
        ["Team": "Team Reel", "Prompt": "Why starting a fire is bad"],
        ["Team": "Team Reel", "Prompt": "Why starting a fire is bad"],
        ["Team": "Team Reel", "Prompt": "Why starting a fire is bad"],
        ["Team": "Team Reel", "Prompt": "Why starting a fire is bad"],
        ["Team": "Team Reel", "Prompt": "Why starting a fire is bad"],
        ["Team": "Team Reel", "Prompt": "Why starting a fire is bad"],
        ["Team": "Team Reel", "Prompt": "Why starting a fire is bad"],
        ["Team": "Team Reel", "Prompt": "Why starting a fire is bad"],
        ["Team": "Team Reel", "Prompt": "Why starting a fire is bad"]
    ]
    
    override func viewDidLoad() {
        setupHeaderView()
        setupTableView()
    }
    
    private func setupHeaderView() {
        
        promptLabel.text = "Your Prompts"
        promptLabel.textColor = .black
        promptLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        
        let viewAllButton = UIButton()
        let attr = NSAttributedString(string: "View All", attributes: [NSAttributedString.Key.foregroundColor: UIColor.link, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13, weight: .light)])
        
        let chev = NSAttributedString(string: " >", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray   , NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .semibold)])
        let mut = NSMutableAttributedString(attributedString: attr)
        mut.append(chev)
        
        viewAllButton.setAttributedTitle(mut, for: .normal)
        
        view.addSubview(promptLabel)
        view.addSubview(viewAllButton)
        
        promptLabel.translatesAutoresizingMaskIntoConstraints = false
        viewAllButton.translatesAutoresizingMaskIntoConstraints = false
        
        promptLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        promptLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 16).isActive = true
        promptLabel.widthAnchor.constraint(equalToConstant: 130).isActive = true
        
        viewAllButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
        viewAllButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 16).isActive = true
        
        
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.register(PromptCell.self, forCellReuseIdentifier: "PromptCell")
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: promptLabel.bottomAnchor, constant: 4).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }
    
    
}

extension PromptsTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return temp.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PromptCell", for: indexPath)

        cell.textLabel?.text = "\(temp[indexPath.row]["Team"]!)"
        cell.detailTextLabel?.text = "\(temp[indexPath.row]["Prompt"]!)"
        
        
        return cell
    }
}
