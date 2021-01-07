//
//  MainTabController.swift
//  Marvel
//
//  Created by Oscar Rodriguez Garrucho on 2/12/20.
//  Copyright © 2020 Little Monster. All rights reserved.
//

import UIKit

class MainTabController: UITabBarController {

    // MARK: - Properties

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    // MARK: - Helpers

    func configureUI() {
        configureViewControllers()

        view.backgroundColor = .white
    }

    func configureViewControllers() {

//        let feed = FeedController(collectionViewLayout: UICollectionViewFlowLayout())
//        let feedNav = templateNavigationController(image: UIImage(named: "home_unselected"),
//                                                   rootViewController: feed)

        let feed = FeedRouter().createFeedModule(navController: false)
        let feedNav = templateNavigationController(image: UIImage(systemName: "list.bullet"),
                                                   rootViewController: feed)

        let favourites = ViewController()
        let favouritesNav = templateNavigationController(image: UIImage(systemName: "star"),
                                                      rootViewController: favourites)

        viewControllers = [feedNav, favouritesNav]
    }

    func templateNavigationController(image: UIImage?,
                                      rootViewController: UIViewController) -> UINavigationController {

        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.image = image
        navController.tabBarItem.title = "Favourites".localized()
        navController.navigationBar.barTintColor = .white

        return navController
    }

}
