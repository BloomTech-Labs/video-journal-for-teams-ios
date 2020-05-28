//
//  TeamsCollectionViewController.swift
//  TeemReel
//
//  Created by scott harris on 5/18/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import UIKit

class TeamsCollectionViewController: UIViewController {
    let apiClient = ApiClient()
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    var authToken: String?
    var orgId: Int?
    var teams: [Team]?
    var temp = [1,2,3,4,5,6,7,8,9]
    var type = "Your Teams"
    let teamLabel = UILabel()
    
    override func viewDidLoad() {
        view.isUserInteractionEnabled = true
//        fetchTeams()
        setupHeaderView()
        configureCollectionView()
    }
    
    private func configureCollectionView() {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//
//        collectionView.collectionViewLayout = layout
        
//        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
//        collectionView.isScrollEnabled = true
//        collectionView.isUserInteractionEnabled = true
        collectionView.register(TeamCell.self, forCellWithReuseIdentifier: "TeamCell")
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: teamLabel.bottomAnchor, constant: 16).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -2).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
    }
    
    private func setupHeaderView() {
        
        teamLabel.text = "\(type)"
        teamLabel.textColor = .black
        teamLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        
        let viewAllButton = UIButton()
        let attr = NSAttributedString(string: "View All", attributes: [NSAttributedString.Key.foregroundColor: UIColor.link, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13, weight: .light)])
        
        let chev = NSAttributedString(string: " >", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray   , NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .semibold)])
        let mut = NSMutableAttributedString(attributedString: attr)
        mut.append(chev)
        
        viewAllButton.setAttributedTitle(mut, for: .normal)
        
        view.addSubview(teamLabel)
        view.addSubview(viewAllButton)
        
        teamLabel.translatesAutoresizingMaskIntoConstraints = false
        viewAllButton.translatesAutoresizingMaskIntoConstraints = false
        
        teamLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        teamLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 16).isActive = true
        teamLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        viewAllButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
        viewAllButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 16).isActive = true
        
        
    }
    
    
    private func fetchTeams() {
        guard let orgId = orgId, let token = authToken else { return }
        apiClient.fetchTeams(for: orgId, token: token) { (teams, error) in
            if let error = error {
                print(error)
                return
            }
            
            self.teams = teams
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
}

extension TeamsCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return temp.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamCell", for: indexPath)
        
        return cell
    }
}

extension TeamsCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = 100
        let height = 145
        let size = CGSize(width: width, height: height)
        return size
    }
}

extension TeamsCollectionViewController: UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
//    }
}



// MARK: - Fix Later!!!
//extension TeamsCollectionViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return teams?.count ?? 0
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let teams = teams else { return UITableViewCell() }
//        let cell = tableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath)
//
//        cell.textLabel?.text = teams[indexPath.row].name
//        cell.detailTextLabel?.text = teams[indexPath.row].description
//
//        return cell
//
//    }
//}
//
//extension TeamsCollectionViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//    }
//}
