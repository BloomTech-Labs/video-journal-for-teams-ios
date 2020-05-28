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
        super.viewWillAppear(animated)
        title = "Dashboard"
        auth()
        fetchOrganizations()
    }
    
    let apiClient = ApiClient()
    let apiController = APIController()
    var organizations: [Organization]?
    var teams: [Team]?
    var prompts: [Prompt]?
    
    lazy var collectionView: UICollectionView = {
        let collectionView: UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: self.makeLayout())
        collectionView.backgroundColor = .systemBackground
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
    
    private func auth() {
        guard let _ = apiController.bearer else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let selectionVc = storyboard.instantiateViewController(withIdentifier: "AuthSelectionScreen") as! AuthSelectionViewController
            selectionVc.modalPresentationStyle = .fullScreen
            selectionVc.apiController = apiController
            selectionVc.delegate = self
            present(selectionVc, animated: true, completion: nil)
            return
        }
        
        fetchOrganizations()
        
    }
    
    private func fetchOrganizations() {
        guard let userId = apiController.currentUser?.id, let token = apiController.bearer?.token else { return }
        apiClient.fetchOrganizations(userId: userId, token: token) { (orgs, error) in
            if let error = error {
                print(error)
                return
            }
            
            self.organizations = orgs
            
            if let orgsToLoop = self.organizations {
                for org in orgsToLoop {
                    let id = org.id
                    let token = self.apiController.bearer?.token ?? ""
                    self.fetchTeams(for: id, authToken: token)
                }
            }
            
            if let teamsToLoop = self.teams {
                for team in teamsToLoop {
                    let id = team.id
                    let token = self.apiController.bearer?.token ?? ""
                    self.fetchPrompts(for: id, authToken: token)
                }
            }
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            
        }
    }
    
    private func fetchTeams(for orgId: Int, authToken: String) {
        
        apiClient.fetchTeams(for: orgId, token: authToken) { (teams, error) in
            if let error = error {
                print(error)
                return
            }
            
            if let _ = self.teams, let teams = teams {
                self.teams?.append(contentsOf: teams)
            } else {
                self.teams = teams
            }
        }
    }
    
    private func fetchPrompts(for teamId: Int, authToken: String) {
        apiClient.fetchPrompts(for: teamId, token: authToken) { (prompts, error) in
            if let error = error {
                print(error)
                return
            }
            
            if let _ = self.prompts, let prompts = prompts {
                self.prompts?.append(contentsOf: prompts)
            } else {
                self.prompts = prompts
            }
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
}

extension DashboardViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return teams?.count ?? 0
        } else if section == 1 {
            return prompts?.count ?? 0
        } else if section == 2 {
            return temp3.count
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamCell", for: indexPath) as? TeamCell else { return UICollectionViewCell() }
            
            let team = self.teams?[indexPath.item]
            
            if let team = team {
                cell.nameLabel.text = team.name
                cell.detailLabel.text = team.description
            }
            
            return cell
        }
        
        if indexPath.section == 1 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PromptCell", for: indexPath) as? PromptCell else { return UICollectionViewCell() }
            
            if let prompt = prompts?[indexPath.item] {
                var team: Team? = nil
                team = self.teams!.filter { $0.id == prompt.teamId }.first
                if let team = team {
                    cell.appTitle.text = team.name
                    cell.appCategory.text = prompt.question
                } else {
                    cell.appTitle.text = "The office"
                    cell.appCategory.text = prompt.question
                }
                
            } else {
                cell.appTitle.text = "Team Reel"
                cell.appCategory.text = "Why Starting Fires is Bad"
            }
            
            
            
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

extension DashboardViewController: Authorized {
    func userWasAuthorized() {
        DispatchQueue.main.async {
            self.fetchOrganizations()
//            self.collectionView.reloadData()
        }
    }
}
