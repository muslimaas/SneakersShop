//
//  CartCoordinator.swift
//  SneakersShop
//
//  Created by Muslima Sandybay on 22.01.2026.
//

import UIKit

final class CartCoordinator: Coordinator {

    let id = UUID()
    var onFinish: (() -> Void)?
    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        showCart()
    }

    private func showCart() {
        let vc = CartViewController()
        navigationController.setViewControllers([vc], animated: false)
    }
}
