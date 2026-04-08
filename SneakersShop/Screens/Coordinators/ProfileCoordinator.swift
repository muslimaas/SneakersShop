//
//  ProfileCoordinator.swift
//  SneakersShop
//
//  Created by Muslima Sandybay on 22.01.2026.
//

import UIKit
import SafariServices
import FirebaseAuth

final class ProfileCoordinator {

    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }


    func start() {
        let vc = ProfileViewController()
        vc.coordinator = self
        navigationController.setViewControllers([vc], animated: false)
    }


    func openAccountInfo() {
        let vc = AccountInfoViewController()
        navigationController.pushViewController(vc, animated: true)
    }

    func openShoeSize() {
        let vc = ShoeSizeViewController()
        navigationController.pushViewController(vc, animated: true)
    }

    func openWeb(url: URL) {
        let safari = SFSafariViewController(url: url)
        navigationController.present(safari, animated: true)
    }


    func logout() {
        do {
            try Auth.auth().signOut()
            navigationController.popToRootViewController(animated: true)

        } catch {
            print("Logout error:", error)
        }
    }
}
