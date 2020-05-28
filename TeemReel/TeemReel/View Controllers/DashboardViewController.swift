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
//        let teamsVC = TeamsCollectionViewController()
//        addChild(teamsVC)
//        view.addSubview(teamsVC.view)
//        teamsVC.didMove(toParent: self)
//        teamsVC.view.translatesAutoresizingMaskIntoConstraints = false
//        teamsVC.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
//        teamsVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
//        teamsVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//        teamsVC.view.heightAnchor.constraint(equalToConstant: 210).isActive = true
//
//        let promptsVC = PromptsTableViewController()
//        addChild(promptsVC)
//        view.addSubview(promptsVC.view)
//        promptsVC.didMove(toParent: self)
//        promptsVC.view.translatesAutoresizingMaskIntoConstraints = false
//        promptsVC.view.topAnchor.constraint(equalTo: teamsVC.view.bottomAnchor, constant: 0).isActive = true
//        promptsVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
//        promptsVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
//        promptsVC.view.heightAnchor.constraint(equalToConstant: 250).isActive = true
//
//        let teamsVC2 = TeamsCollectionViewController()
//        teamsVC2.type = "Videos"
//        addChild(teamsVC2)
//        view.addSubview(teamsVC2.view)
//        teamsVC2.didMove(toParent: self)
//        teamsVC2.view.translatesAutoresizingMaskIntoConstraints = false
//        teamsVC2.view.topAnchor.constraint(equalTo: promptsVC.view.bottomAnchor, constant: 16).isActive = true
//        teamsVC2.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
//        teamsVC2.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//        teamsVC2.view.heightAnchor.constraint(equalToConstant: 210).isActive = true
        
        
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
    
    lazy var collectionView: UICollectionView = {
        let collectionView: UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: self.makeLayout())
        collectionView.backgroundColor = .systemBackground
        //        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TeamCell.self, forCellWithReuseIdentifier: "TeamCell")
        collectionView.register(PromptCell.self, forCellWithReuseIdentifier: "PromptCell")
        collectionView.register(VideoCell.self, forCellWithReuseIdentifier: "VideoCell")
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: "header", withReuseIdentifier: "HeaderView")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    var temp = [1,2,3,4,5,6,7,8,9]
    var temp2 = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16]
    var temp3 = [1,2,3,4,5,6,7,8,9]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.collectionView)
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        ])
        
    }
    
    func makeLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (section: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
                if section == 0 {
                    return self.makeHorizontalRow(width: 108, height: 145)
                } else if section == 1 {
                    return self.makeHorizontalList()
                } else {
                    return self.makeHorizontalRow(width: 164, height: 164)
                }
    
        }
        
        return layout
    }
    
    func makeHorizontalRow(width: CGFloat, height: CGFloat) -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 0.0, leading: 0.0, bottom: 0.0, trailing: 8.0)
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .estimated(width + item.contentInsets.trailing), heightDimension: .estimated(height)), subitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 4.0, leading: 8.0, bottom: 16.0, trailing: 0.0)
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
        let headerElement = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: "header", alignment: .top)
        section.boundarySupplementaryItems = [headerElement]
        
        return section
    }
    
    func makeHorizontalList() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 4.0, leading: 0.0, bottom: 0.0, trailing: 8.0)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalHeight(0.35)), subitem: item, count: 4)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 4.0, leading: 8.0, bottom: 16.0, trailing: 0.0)
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
        let headerElement = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: "header", alignment: .top)
        section.boundarySupplementaryItems = [headerElement]
        
        return section
    }
}

extension DashboardViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return temp.count
        } else if section == 1 {
            return temp2.count
        } else if section == 2 {
            return temp3.count
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamCell", for: indexPath)
            
            return cell
        }
        
        if indexPath.section == 1 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PromptCell", for: indexPath) as? PromptCell else { return UICollectionViewCell() }
            
            cell.appTitle.text = "Team Reel"
            cell.appCategory.text = "Why Starting Fires is Bad"
            
            return cell
            
        }
        
        if indexPath.section == 2 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCell", for: indexPath) as? VideoCell else { return UICollectionViewCell() }
            
            return cell
        }
        
        return UICollectionViewCell()
       
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if (kind == "header") {
            print("Was aheader:")
        }
        
        guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: "header", withReuseIdentifier: "HeaderView", for: indexPath) as? HeaderView else { return HeaderView() }
        
        if indexPath.section == 0 {
            view.type = "Your Teams"
        } else if indexPath.section == 1 {
            view.type = "Your Prompts"
        } else if indexPath.section == 2 {
            view.type = "Videos"
        }
        
        
        return view
    }
}
