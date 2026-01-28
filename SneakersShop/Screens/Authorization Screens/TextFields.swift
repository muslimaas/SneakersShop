//
//  TextFields.swift
//  SneakersShop
//
//  Created by Muslima Sandybay on 15.01.2026.
//

import UIKit
import SnapKit

final class TextFieldView: UIView {

    private let textField = UITextField()


    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        setupConstraints()
    }

    private func setupView() {
        backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
        layer.cornerRadius = 4

        textField.font = .systemFont(ofSize: 17)
        textField.textColor = .black
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.backgroundColor = .clear

        let paddingView = UIView()
        paddingView.snp.makeConstraints { $0.width.equalTo(16) }
        textField.leftView = paddingView
        textField.leftViewMode = .always

        addSubview(textField)
    }

    private func setupConstraints() {
        snp.makeConstraints {$0.height.equalTo(56)
        }

        textField.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func setTextField( placeholder: String, isSecure: Bool = false
    ) {
        textField.placeholder = placeholder
        textField.isSecureTextEntry = isSecure
    }

    func value() -> String {
        textField.text ?? ""
    }
}

