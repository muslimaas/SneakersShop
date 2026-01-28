//
//  CatalogCoordinator.swift
//  SneakersShop
//
//  Created by Muslima Sandybay on 16.01.2026.
//

import UIKit

final class CatalogCoordinator: Coordinator {

    let id = UUID()
    var onFinish: (() -> Void)?
    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        showCatalog()
    }

    private func showCatalog() {
        let vc = CatalogViewController()
        navigationController.setViewControllers([vc], animated: false)
    }
}
