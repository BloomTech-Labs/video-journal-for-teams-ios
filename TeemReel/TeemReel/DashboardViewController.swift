//
//  DashboardViewController.swift
//  TeemReel
//
//  Created by scott harris on 5/21/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        title = "Dashboard"
        let teamsVC = TeamsCollectionViewController()
        addChild(teamsVC)
        view.addSubview(teamsVC.view)
        teamsVC.didMove(toParent: self)
        teamsVC.view.translatesAutoresizingMaskIntoConstraints = false
        teamsVC.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        teamsVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        teamsVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        teamsVC.view.heightAnchor.constraint(equalToConstant: 210).isActive = true
        
        let promptsVC = PromptsTableViewController()
        addChild(promptsVC)
        view.addSubview(promptsVC.view)
        promptsVC.didMove(toParent: self)
        promptsVC.view.translatesAutoresizingMaskIntoConstraints = false
        promptsVC.view.topAnchor.constraint(equalTo: teamsVC.view.bottomAnchor, constant: 0).isActive = true
        promptsVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        promptsVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        promptsVC.view.heightAnchor.constraint(equalToConstant: 250).isActive = true
        
        let teamsVC2 = TeamsCollectionViewController()
        teamsVC2.type = "Videos"
        addChild(teamsVC2)
        view.addSubview(teamsVC2.view)
        teamsVC2.didMove(toParent: self)
        teamsVC2.view.translatesAutoresizingMaskIntoConstraints = false
        teamsVC2.view.topAnchor.constraint(equalTo: promptsVC.view.bottomAnchor, constant: 16).isActive = true
        teamsVC2.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        teamsVC2.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        teamsVC2.view.heightAnchor.constraint(equalToConstant: 210).isActive = true
        
        
//        let teamsVC3 = TeamsCollectionViewController()
//        teamsVC3.type = "Videos"
//        addChild(teamsVC3)
//        view.addSubview(teamsVC3.view)
//        teamsVC3.didMove(toParent: self)
//        teamsVC3.view.translatesAutoresizingMaskIntoConstraints = false
//        teamsVC3.view.topAnchor.constraint(equalTo: teamsVC2.view.bottomAnchor, constant: 16).isActive = true
//        teamsVC3.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
//        teamsVC3.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//        teamsVC3.view.heightAnchor.constraint(equalToConstant: 210).isActive = true
//        
//        let teamsVC4 = TeamsCollectionViewController()
//        teamsVC4.type = "Videos"
//        addChild(teamsVC4)
//        view.addSubview(teamsVC4.view)
//        teamsVC4.didMove(toParent: self)
//        teamsVC4.view.translatesAutoresizingMaskIntoConstraints = false
//        teamsVC4.view.topAnchor.constraint(equalTo: teamsVC3.view.bottomAnchor, constant: 16).isActive = true
//        teamsVC4.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
//        teamsVC4.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//        teamsVC4.view.heightAnchor.constraint(equalToConstant: 210).isActive = true

    }
}
