//
//  TeamsTableViewController.swift
//  TeemReel
//
//  Created by scott harris on 5/18/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import UIKit

class TeamsTableViewController: UIViewController {
    let apiClient = ApiClient()
    let tableView = UITableView()
    var authToken: String?
    var orgId: Int?
    var teams: [Team]?
    
    override func viewDidLoad() {
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "BasicCell")
        setupTableView()
        fetchTeams()
    }
    
    private func setupTableView() {
        self.view.addSubview(tableView)
        
        tableView.dataSource = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
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
                self.tableView.reloadData()
            }
        }
    }
    
}

extension TeamsTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teams?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let teams = teams else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath)
        
        cell.textLabel?.text = teams[indexPath.row].name
        cell.detailTextLabel?.text = teams[indexPath.row].description
        
        return cell
        
    }
}

extension TeamsTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
