//
//  SignUp.swift
//  SneakersShop
//
//  Created by Muslima Sandybay on 15.01.2026.
//

import UIKit
import SnapKit

final class SignUpViewController: UIViewController {

    private let usernameField = TextFieldView()
    private let passwordField = TextFieldView()
    private let repeatField = TextFieldView()


    private let loginButton: BigButtonView = {
        let button = BigButtonView()
        button.setTitle("Sign Up")
        return button
    }()


    var onSignUp: ((_ username: String, _ password: String, _ repeatPassword: String) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "New User"
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
        
        repeatField.setTextField(
            placeholder: "Repeat password",
            isSecure: true
        )
    }

    private func setupLayout() {
        view.addSubview(usernameField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        view.addSubview(repeatField)


        usernameField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(52)
            $0.leading.trailing.equalToSuperview().inset(24)
        }

        passwordField.snp.makeConstraints {
            $0.top.equalTo(usernameField.snp.bottom).offset(16)
            $0.leading.trailing.equalTo(usernameField)
        }
        
        repeatField.snp.makeConstraints {
                    $0.top.equalTo(passwordField.snp.bottom).offset(16)
                    $0.leading.trailing.equalTo(usernameField)
                }

        loginButton.snp.makeConstraints {
            $0.top.equalTo(repeatField.snp.bottom).offset(416)
            $0.leading.trailing.equalTo(usernameField)
            $0.height.equalTo(54)
        }
    }

    private func setupActions() {
        loginButton.onTap = { [weak self] in
            guard let self else { return }

            let username = self.usernameField.value()
            let password = self.passwordField.value()
            let repeatPassword = self.repeatField.value()

            self.onSignUp?(username, password, repeatPassword)
        }
    }
}
