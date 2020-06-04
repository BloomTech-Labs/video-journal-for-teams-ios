//
//  OrganizationsTableViewController.swift
//  TeemReel
//
//  Created by scott harris on 5/18/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import UIKit

class OrganizationsTableViewController: UIViewController {
    let apiClient = ApiClient()
    let apiController = APIController()
    let tableView = UITableView()
    var organizations: [Organization]?
    
    override func viewWillAppear(_ animated: Bool) {
        auth()
        fetchOrganizations()
    }
    
    override func viewDidLoad() {
        title = "My Organizations"
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "BasicCell")
        setupTableView()
        self.view.backgroundColor = .clear
        
    }
    
    private func auth() {
        guard let _ = apiController.bearer else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let selectionVc = storyboard.instantiateViewController(withIdentifier: "AuthSelectionScreen") as! AuthSelectionViewController
            selectionVc.modalPresentationStyle = .fullScreen
            selectionVc.apiController = apiController
            present(selectionVc, animated: true, completion: nil)
            return
        }
    }
    
    private func setupTableView() {
        self.view.addSubview(tableView)
        
        tableView.dataSource = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    private func fetchOrganizations() {
        guard let userId = apiController.currentUser?.id, let token = apiController.bearer?.token else { return }
        apiClient.fetchOrganizations(userId: userId, token: token) { (orgs, error) in
            if let error = error {
                print(error)
                return
            }
            
        self.organizations = orgs
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
}

extension OrganizationsTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return organizations?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let organizations = organizations else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath)
        
        cell.textLabel?.text = organizations[indexPath.row].name
        
        return cell
        
    }
}

extension OrganizationsTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let organizations = organizations else { return }
        let teamsVC = TeamsCollectionViewController()
        teamsVC.orgId = organizations[indexPath.row].id
        teamsVC.authToken = apiController.bearer?.token
        navigationController?.pushViewController(teamsVC, animated: true)
    }
}
