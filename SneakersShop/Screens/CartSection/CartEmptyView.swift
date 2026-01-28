//
//  CartEmptyView.swift
//  SneakersShop
//
//  Created by Muslima Sandybay on 22.01.2026.
//

import UIKit
import SnapKit

final class CartEmptyView: UIView {

    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        backgroundColor = .systemBackground

        imageView.image = UIImage(named: "cart_empty_bg")
        imageView.contentMode = .scaleAspectFill

        titleLabel.text = "Cart is empty"
        titleLabel.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
        titleLabel.textAlignment = .center

        subtitleLabel.text = "Find interesting models in the Catalog."
        subtitleLabel.font = .systemFont(ofSize: 17)
        subtitleLabel.textAlignment = .center

        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(subtitleLabel)

        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(80)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(200)
        }

        titleLabel.snp.makeConstraints {
            $0.bottom.equalTo(subtitleLabel.snp.top).offset(-16)
            $0.centerX.equalToSuperview()
        }

        subtitleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(32)
            $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-302)
        }
    }
}
