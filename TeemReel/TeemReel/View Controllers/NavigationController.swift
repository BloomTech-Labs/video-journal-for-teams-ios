//
//  NavigationController.swift
//  TeemReel
//
//  Created by scott harris on 5/21/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    
    override func viewWillAppear(_ animated: Bool) {
//        navigationBar.backgroundColor = UIColor.purple
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.backgroundColor = UIColor(named: "App-Purple")
        navBarAppearance.shadowImage = nil
        navBarAppearance.shadowColor = nil
//        navigationBar.prefersLargeTitles = false
        navigationBar.overrideUserInterfaceStyle = .dark
        navigationBar.standardAppearance = navBarAppearance
        navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationBar.compactAppearance = navBarAppearance
        
    }
    
}
