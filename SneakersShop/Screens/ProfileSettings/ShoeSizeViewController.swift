//
//  ShoeSizeViewController.swift
//  SneakersShop
//
//  Created by Muslima Sandybay on 14.02.2026.
//

import UIKit
import SnapKit

final class ShoeSizeViewController: UIViewController {

    private let textField = UITextField()
    private let saveButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Shoe Size"
        view.backgroundColor = .systemBackground

        setupUI()
    }
}

private extension ShoeSizeViewController {

    func setupUI() {

        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad

        saveButton.setTitle("Save changes", for: .normal)
        saveButton.backgroundColor = .black
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.layer.cornerRadius = 28

        view.addSubview(textField)
        view.addSubview(saveButton)

        textField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(50)
        }

        saveButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(56)
        }
    }
}
