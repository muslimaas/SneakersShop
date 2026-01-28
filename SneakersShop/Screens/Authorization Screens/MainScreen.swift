//
//  MainScreen.swift
//  SneakersShop
//
//  Created by Muslima Sandybay on 13.01.2026.
//

import UIKit
final class WelcomeViewController: UIViewController {
    
    var onSignUp: (() -> Void)?
    var onLogin: (() -> Void)?


    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Image 2")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()


    private let titleView: BigTitle = {
        let view = BigTitle()
        view.label.text = "Welcome to the biggest\nsneakers store app"
        view.label.textAlignment = .center
        return view
    }()

    private let signUpButton: BigButtonView = {
        let button = BigButtonView()
        button.setTitle("Sign Up")
        return button
    }()

    private let loginButton: BigButtonView = {
        let button = BigButtonView()
        button.setTitle("I already have an account")
        button.BackColor(.white)
        return button
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupActions()
    }


    private func setupView() {
        view.backgroundColor = .white

        view.addSubview(backgroundImageView)
        view.addSubview(titleView)
        view.addSubview(signUpButton)
        view.addSubview(loginButton)

        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        titleView.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            
            loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            signUpButton.bottomAnchor.constraint(equalTo: loginButton.topAnchor, constant: -8),
            signUpButton.heightAnchor.constraint(equalToConstant: 64),

            titleView.bottomAnchor.constraint(equalTo: signUpButton.topAnchor, constant: -24),
            titleView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            titleView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
])
    }

    private func setupActions() {
        signUpButton.onTap = { [weak self] in
            self?.onSignUp?()
        }

        loginButton.onTap = { [weak self] in
            self?.onLogin?()
        }
    }
}
