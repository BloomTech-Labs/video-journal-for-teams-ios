//
//  TeamsDashboardViewController.swift
//  TeamReel
//
//  Created by scott harris on 6/16/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import UIKit

class TeamsDashboardViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeaderView()
//        self.view.addSubview(self.collectionView)
//        NSLayoutConstraint.activate([
//            self.collectionView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
//            self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
//            self.collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
//            self.collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
//        ])
        
    }
    
    var team: Team?
    
    lazy var collectionView: UICollectionView = {
        let collectionView: UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: self.makeLayout())
        collectionView.backgroundColor = .systemBackground
        collectionView.dataSource = self
        collectionView.delegate = self
        
        
        collectionView.register(PromptCompositionalCell.self, forCellWithReuseIdentifier: "PromptCell")
        collectionView.register(VideoCell.self, forCellWithReuseIdentifier: "VideoCell")
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: "header", withReuseIdentifier: "HeaderView")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    func makeLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (section: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            if section == 0 {
                let width = self.view.bounds.size.width
                return self.makeHorizontalRow(width: width, height: 145)
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
    
    private func setupHeaderView() {
        let headerView = TeamHeaderView()
        view.addSubview(headerView)
        headerView.team = team
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        headerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        headerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        headerView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, constant: 300).isActive = true
    }

}


extension TeamsDashboardViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if section == 0 {
//            return teams?.count ?? 0
//        } else if section == 1 {
//            return prompts?.count ?? 0
//        } else if section == 2 {
//            return temp3.count
//        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamCell", for: indexPath) as? TeamCell else { return UICollectionViewCell() }
            
//            let team = self.teams?[indexPath.item]
//
//            if let team = team {
//                cell.nameLabel.text = team.name
//                cell.detailLabel.text = team.description
//            }
            
            return cell
        }
        
        if indexPath.section == 1 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PromptCell", for: indexPath) as? PromptCompositionalCell else { return UICollectionViewCell() }
            
//            if let prompt = prompts?[indexPath.item] {
//                var team: Team? = nil
//                team = self.teams!.filter { $0.id == prompt.teamId }.first
//                if let team = team {
//                    cell.appTitle.text = team.name
//                    cell.appCategory.text = prompt.question
//                } else {
//                    cell.appTitle.text = "The office"
//                    cell.appCategory.text = prompt.question
//                }
//
//            } else {
//                cell.appTitle.text = "Team Reel"
//                cell.appCategory.text = "Why Starting Fires is Bad"
//            }
            
            
            
            return cell
            
        }
        
        if indexPath.section == 2 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCell", for: indexPath) as? VideoCell else { return UICollectionViewCell() }
            
            return cell
        }
        
        return UICollectionViewCell()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: "header", withReuseIdentifier: "HeaderView", for: indexPath) as? HeaderView else { return HeaderView() }
        
        if indexPath.section == 0 {
            view.type = "Your Teams"
            
        } else if indexPath.section == 1 {
            view.type = "Your Prompts"
//            view.viewAllButton.addTarget(self, action: #selector(viewAllPromptsTapped), for: .touchUpInside)
        } else if indexPath.section == 2 {
            view.type = "Videos"
        }
        
        
        return view
    }
}

extension TeamsDashboardViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = indexPath.section
        if section == 1 {
            print("Its a prompt!!")
//            let prompt = prompts?[indexPath.item]
//            if let prompt = prompt {
//                print("The prompt question is: \(prompt.question)")
//                let promptVC = PromptsCollectionViewController()
//                promptVC.prompts = [prompt]
//                // TODO: - Revisit ?!?!?!?
//                //                promptVC.apiController = apiController
//                navigationController?.pushViewController(promptVC, animated: true)
//            }
        }
    }
}
