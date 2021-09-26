//
//  MainTabBarController.swift
//  Evaluation Test iOS
//
//  Created by Artem Ekimov on 24.09.2021.
//

import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        viewControllers = [
            produceNavController(viewController: AlbumsSearchController(), title: "Search", imageName: "search"),
            produceNavController(viewController: HistoryViewController(), title: "History", imageName: "history")
        ]
    }
    
    // Method produceNavController is created in order to eliminate repeating code while initialising ViewControllers
    fileprivate func produceNavController(viewController: UIViewController, title: String, imageName: String) -> UIViewController {
        
        let navController = UINavigationController(rootViewController: viewController)
        viewController.view.backgroundColor = .white
        viewController.navigationItem.title = title
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(named: imageName)
        navController.navigationBar.prefersLargeTitles = true
        
        return navController
    }
}
