//
//  ProfileCoordinator.swift
//  SneakersShop
//
//  Created by Muslima Sandybay on 22.01.2026.
//

import UIKit

final class ProfileCoordinator {

    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = ProfileViewController()
        vc.onEditProfile = { [weak self] in
            self?.showEditProfile()
        }
        vc.onChangePassword = { [weak self] in
            self?.showChangePassword()
        }
        vc.onLogout = { [weak self] in
            self?.showLogoutAlert()
        }
        navigationController.setViewControllers([vc], animated: false)
    }

    private func showEditProfile() {
        navigationController.pushViewController(EditProfileViewController(), animated: true)
    }

    private func showChangePassword() {
        navigationController.pushViewController(ChangePasswordViewController(), animated: true)
    }

    private func showLogoutAlert() {
        let alert = UIAlertController(
            title: "Sign out",
            message: "Are you sure you want to sign out?",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Confirm", style: .destructive) { _ in
        })
        navigationController.present(alert, animated: true)
    }
}
