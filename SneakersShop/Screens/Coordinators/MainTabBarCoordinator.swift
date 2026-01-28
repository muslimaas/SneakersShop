//
//  MainTabBarCoordinator.swift
//  SneakersShop
//
//  Created by Muslima Sandybay on 16.01.2026.
//

import UIKit

final class MainTabBarCoordinator: Coordinator {

    let id = UUID()
    var onFinish: (() -> Void)?
    let navigationController: UINavigationController

    private let tabBarController = UITabBarController()

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        setupTabs()
        
        navigationController.setViewControllers([tabBarController], animated: true)
    }

    private func setupTabs() {
        let catalogNav = UINavigationController()
        let catalogCoordinator = CatalogCoordinator(
            navigationController: catalogNav
        )
        catalogCoordinator.start()

        catalogNav.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill"),
            
        )


        let cartNav = UINavigationController()
        let cartCoordinator = CartCoordinator(
                navigationController: cartNav)
        cartCoordinator.start()

        cartNav.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(systemName: "cart"),
            selectedImage: UIImage(systemName: "cart.fill")
        )
        
        let profileNav = UINavigationController()
        let profileCoordinator = ProfileCoordinator(
            navigationController: profileNav)
        profileCoordinator.start()
        
        profileNav.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(systemName: "person"),
            selectedImage: UIImage(systemName: "person.fill")
        )

        tabBarController.viewControllers = [
                catalogNav,
                cartNav,
                profileNav
            ]
    }
}
