//
//  AuthCoordinator.swift
//  SneakersShop
//
//  Created by Muslima Sandybay on 16.01.2026.
//

import Foundation
import UIKit

final class AuthCoordinator: Coordinator {
    func start() {
        showWelcome()
    }
    
    
    let id = UUID()
    let navigationController: UINavigationController
    var onFinish: (() -> Void)?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    
    func showWelcome() {
           let vc = WelcomeViewController()

           vc.onSignUp = { [weak self] in
               self?.showSignUp()
           }

           vc.onLogin = { [weak self] in
               self?.showLogin()
           }

           navigationController.setViewControllers([vc], animated: true)
       }

       func showSignUp() {
           let vc = SignUpViewController()

           vc.onSignUp = { [weak self] email, password, _ in
               AuthService.shared.signUp(email: email, password: password) { result in
                   DispatchQueue.main.async {
                       switch result {
                       case .success:
                           print("Registered")
                           self?.onFinish?()

                       case .failure(let error):
                           print("Error:", error.localizedDescription)
                       }
                   }
               }
           }

           navigationController.pushViewController(vc, animated: true)
       }

       func showLogin() {
           let vc = LoginViewController()

           vc.onLogin = { [weak self] email, password in
               AuthService.shared.signIn(email: email, password: password) { result in
                   DispatchQueue.main.async {
                       switch result {
                       case .success:
                           print("Logged in")
                           self?.onFinish?()

                       case .failure(let error):
                           print(error.localizedDescription)
                       }
                   }
               }
           }

           navigationController.pushViewController(vc, animated: true)
       }
    
    

}

