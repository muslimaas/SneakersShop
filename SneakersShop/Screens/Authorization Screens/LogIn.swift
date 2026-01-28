//
//  LogIn.swift
//  SneakersShop
//
//  Created by Muslima Sandybay on 15.01.2026.
//

import UIKit
import SnapKit

final class LoginViewController: UIViewController {

    private let usernameField = TextFieldView()
    private let passwordField = TextFieldView()

    private let loginButton: BigButtonView = {
        let button = BigButtonView()
        button.setTitle("Sign In")
        return button
    }()


    var onLogin: ((_ email: String, _ password: String) -> Void)?


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Welcome back!"
        setupFields()
        setupLayout()
        setupActions()
    }


    private func setupFields() {
        usernameField.setTextField(
            placeholder: "Username",
            isSecure: false
        )

        passwordField.setTextField(
            placeholder: "Password",
            isSecure: true
        )
    }

    private func setupLayout() {
        view.addSubview(usernameField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)



        usernameField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(52)
            $0.leading.trailing.equalToSuperview().inset(24)
        }

        passwordField.snp.makeConstraints {
            $0.top.equalTo(usernameField.snp.bottom).offset(16)
            $0.leading.trailing.equalTo(usernameField)
        }

        loginButton.snp.makeConstraints {
            $0.top.equalTo(passwordField.snp.bottom).offset(480)
            $0.leading.trailing.equalTo(usernameField)
            $0.height.equalTo(54)
        }
    }

    private func setupActions() {
        loginButton.onTap = { [weak self] in
            guard let self else { return }

            let username = self.usernameField.value()
            let password = self.passwordField.value()

            self.onLogin?(username, password)
        }
    }
}
