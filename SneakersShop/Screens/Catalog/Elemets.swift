//
//  Elemets.swift
//  SneakersShop
//
//  Created by Muslima Sandybay on 16.01.2026.
//

import UIKit
import SnapKit

final class CatalogActionButtonView: UIView {

    enum Style {
        case add
        case remove
    }

    private let button = UIButton(type: .system)
    var onTap: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        addSubview(button)

        // Pin the internal button to this view’s edges; let the parent decide this view’s size.
        button.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        button.layer.cornerRadius = 16
        button.clipsToBounds = true

        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .regular)
        button.setTitleColor(.white, for: .normal)

        button.addTarget(self, action: #selector(didTap), for: .touchUpInside)
    }

    func configure(style: Style) {
        switch style {
        case .add:
            button.setTitle("Add to cart", for: .normal)
            button.backgroundColor = .black

        case .remove:
            button.setTitle("Remove", for: .normal)
            button.backgroundColor = .darkGray
        }
    }

    @objc private func didTap() {
        onTap?()
    }
}

