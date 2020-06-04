//
//  ViewController.swift
//  TeemReel
//
//  Created by scott harris on 5/14/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let apiClient = ApiClient()
    let userId = 197
    var organizations: [Organization]?
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "BasicCell")
        fetchOrganizations()
        setupTableView()
        
    }
    
    private func setupTableView() {
        self.view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate =  self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    
    private func fetchOrganizations() {
        apiClient.fetchOrganizations(userId: userId) { (organizations, error) in
            if let error = error {
                print(error)
                return
            }
            
            self.organizations = organizations
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
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

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let organizations = organizations else { return }
        let id = organizations[indexPath.row].id
        
        let vc = TeamsTableViewController()
        vc.orgId = id
        
        present(vc, animated: true, completion: nil)
        
    }
}

