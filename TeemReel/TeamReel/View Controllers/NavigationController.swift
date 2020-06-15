//
//  NavigationController.swift
//  TeemReel
//
//  Created by scott harris on 5/21/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    
    override func viewDidLoad() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.backgroundColor = UIColor(named: "App-Purple")
        navBarAppearance.shadowImage = nil
        navBarAppearance.shadowColor = nil
//        navigationBar.barTintColor = .white
//        navigationItem.leftBarButtonItem?.tintColor = .white
//        navigationBar.backItem?.backBarButtonItem?.tintColor = .white
        UINavigationBar.appearance().tintColor = .white
        navigationBar.prefersLargeTitles = false
        navigationBar.overrideUserInterfaceStyle = .dark
        navigationBar.standardAppearance = navBarAppearance
        navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationBar.compactAppearance = navBarAppearance
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        navigationBar.backgroundColor = UIColor.purple
//        let navBarAppearance = UINavigationBarAppearance()
//        navBarAppearance.configureWithOpaqueBackground()
//        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
//        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
//        navBarAppearance.backgroundColor = UIColor(named: "App-Purple")
//        navBarAppearance.shadowImage = nil
//        navBarAppearance.shadowColor = nil
//        navigationBar.prefersLargeTitles = false
//        navigationBar.overrideUserInterfaceStyle = .dark
//        navigationBar.standardAppearance = navBarAppearance
//        navigationBar.scrollEdgeAppearance = navBarAppearance
//        navigationBar.compactAppearance = navBarAppearance
        
    }
    
}
