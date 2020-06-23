//
//  DashboardViewController.swift
//  TeemReel
//
//  Created by scott harris on 5/21/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {
    let apiController = APIController()
    let teamsController = TeamController()
    let promptsController = PromptController()
    let videosController = VideosController()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Dashboard"
        auth()

    }
    
    
//    var organizations: [Organization]?
//    var teams: [Team]? {
//        didSet {
//            DispatchQueue.main.async {
//                self.collectionView.reloadSections(IndexSet(integer: 0))
//            }
//        }
//    }
//    var prompts: [Prompt]? {
//        didSet {
//            DispatchQueue.main.async {
//                self.collectionView.reloadSections(IndexSet(integer: 1))
//            }
//        }
//    }
//
//    var videos: [Video]? {
//        didSet {
//            DispatchQueue.main.async {
//                self.collectionView.reloadSections(IndexSet(integer: 2))
//            }
//        }
//    }
    
    lazy var collectionView: UICollectionView = {
        let collectionView: UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: self.makeLayout())
        collectionView.backgroundColor = .systemBackground
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(TeamCell.self, forCellWithReuseIdentifier: "TeamCell")
        collectionView.register(PromptCompositionalCell.self, forCellWithReuseIdentifier: "PromptCell")
        collectionView.register(VideoCell.self, forCellWithReuseIdentifier: "VideoCell")
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: "header", withReuseIdentifier: "HeaderView")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.collectionView)
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        ])
        
        if let token = apiController.bearer?.token, let userId = apiController.bearer?.user.id {
            teamsController.fetchTeams(for: userId, authToken: token) {
                DispatchQueue.main.async {
//                    self.collectionView.reloadSections(IndexSet(integer: 0))
                }
            }
            promptsController.fetchUsersPrompts(for: userId, authToken: token) {
                DispatchQueue.main.async {
//                    self.collectionView.reloadSections(IndexSet(integer: 1))
                    self.collectionView.reloadData()
                }
            }
            videosController.fetchVideos(for: userId, token: token) {
                DispatchQueue.main.async {
//                    self.collectionView.reloadSections(IndexSet(integer: 1))
                    self.collectionView.reloadData()
                }
            }
        }
        
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
        guard let _ = apiController.token, let _ = apiController.user else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let selectionVc = storyboard.instantiateViewController(withIdentifier: "AuthSelectionScreen") as! AuthSelectionViewController
            selectionVc.modalPresentationStyle = .fullScreen
            selectionVc.apiController = apiController
            selectionVc.delegate = self
            present(selectionVc, animated: true, completion: nil)
            return
        }
        
        
    }
    
//    private func fetchOrganizations() {
//        guard let userId = apiController.user?.id, let token = apiController.bearer?.token else { return }
//        apiClient.fetchOrganizations(userId: userId, token: token) { (orgs, error) in
//            if let error = error {
//                print(error)
//                self.auth()
//                return
//            }
//
//            self.organizations = orgs
//        }
//    }
    
    @objc func viewAllPromptsTapped() {
        let promptVC = PromptsCollectionViewController()
        let prompts = promptsController.prompts
        promptVC.prompts = prompts

        promptVC.apiController = apiController
        navigationController?.pushViewController(promptVC, animated: true)
    }
    
}

extension DashboardViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return teamsController.teams.count
        } else if section == 1 {
            return promptsController.prompts.count
        } else if section == 2 {
            return videosController.videos.count
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamCell", for: indexPath) as? TeamCell else { return UICollectionViewCell() }
            
            let team = teamsController.teams[indexPath.item]
            
            cell.nameLabel.text = team.name
            cell.detailLabel.text = team.description
            
            return cell
        }
        
        if indexPath.section == 1 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PromptCell", for: indexPath) as? PromptCompositionalCell else { return UICollectionViewCell() }
            
                let prompt = promptsController.prompts[indexPath.item]
                var team: Team? = nil
                team = teamsController.teams.filter { $0.id == prompt.teamId }.first
                if let team = team {
                    cell.team = team
                    cell.prompt = prompt

                } else {
                    cell.teamNameLabel.text = "The office"
                    cell.questionLabel.text = prompt.question
                }
            
            return cell
            
        }
        
        if indexPath.section == 2 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCell", for: indexPath) as? VideoCell else { return UICollectionViewCell() }
            
            let video = videosController.videos[indexPath.item]
            var image: UIImage?
                DispatchQueue.global(qos: .userInitiated).async {
                    image = Utilities.createThumbnailOfVideoFromRemoteUrl(url: "https://alpaca-vids-storage.s3-us-west-1.amazonaws.com/\(video.videoURL)")
                    DispatchQueue.main.async {
                        cell.imageView.image = image
                        print("set image from dashboard VC")
                    }
                }
            
            return cell
        }
        
        return UICollectionViewCell()
       
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: "header", withReuseIdentifier: "HeaderView", for: indexPath) as? HeaderView else { return HeaderView() }
        
        if indexPath.section == 0 {
            view.type = "Your Teams"
            view.viewAllButton.isHidden = true
        } else if indexPath.section == 1 {
            view.type = "Your Prompts"
            view.viewAllButton.isHidden = false
            view.viewAllButton.addTarget(self, action: #selector(viewAllPromptsTapped), for: .touchUpInside)
        } else if indexPath.section == 2 {
            view.type = "Videos"
            view.viewAllButton.isHidden = true
        }
        
        
        return view
    }
}

extension DashboardViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = indexPath.section
        if section == 0 {
            let team = teamsController.teams[indexPath.item]
            let teamVC = TeamsDashboardViewController()
            teamVC.team = team
            teamVC.apiController = apiController
            teamVC.apiToken = apiController.token
            navigationController?.pushViewController(teamVC, animated: true)
        }
        
        if section == 1 {
            print("Its a prompt!!")
            let prompt = promptsController.prompts[indexPath.item]
            print("The prompt question is: \(prompt.question)")
            let promptVC = PromptsCollectionViewController()
            promptVC.prompts = [prompt]

            promptVC.apiController = apiController
            navigationController?.pushViewController(promptVC, animated: true)
        }
        
        if section == 2 {
            let video = videosController.videos[indexPath.item]
            let playerVC = PromptResponseViewController()
            navigationController?.pushViewController(playerVC, animated: true)
            let url = URL(string: "https://alpaca-vids-storage.s3-us-west-1.amazonaws.com/\(video.videoURL)")
            playerVC.videoURL = url
            playerVC.video = video
                
        }
    }
}

extension DashboardViewController: Authorized {
    func userWasAuthorized() {
        DispatchQueue.main.async {
            
        }
    }
}
