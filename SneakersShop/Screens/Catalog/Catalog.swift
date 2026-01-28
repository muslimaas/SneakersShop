//
//  Catalog.swift
//  SneakersShop
//
//  Created by Muslima Sandybay on 16.01.2026.
//

import Foundation
import SnapKit
import UIKit
import FirebaseFirestore

struct CatalogItem {
    let id: String
    let sneakers: String
    let description: String
    let price: Int
    let image: String


}

class CatalogCell: UICollectionViewCell {
    
    static let reuseIdentifier = "CatalogCell"

    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let priceLabel = UILabel()
    private let actionButton = CatalogActionButtonView()
    var onActionTap: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 4
        contentView.clipsToBounds = true
        
        titleLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        descriptionLabel.font = .systemFont(ofSize: 12, weight: .regular)
        descriptionLabel.textColor = .secondaryLabel
        
        priceLabel.font = .systemFont(ofSize: 12, weight: .semibold)

        imageView.contentMode = .scaleAspectFit
        
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(actionButton)

        setupConstraints()
    }
    
    func configure(with item: CatalogItem) {
        titleLabel.text = item.sneakers
        descriptionLabel.text = item.description

        let count = CartService.shared.quantity(for: item.id)

        if count > 0 {
            priceLabel.text = "\(count) • $\(item.price)"
            actionButton.configure(style: .remove)
        } else {
            priceLabel.text = "$\(item.price)"
            actionButton.configure(style: .add)
        }

        actionButton.onTap = { [weak self] in
            self?.onActionTap?()
        }

        if let url = URL(string: item.image) {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
                guard let data, let image = UIImage(data: data) else { return }
                DispatchQueue.main.async {
                    self?.imageView.image = image
                }
            }.resume()
        }
    }
    

    private func setupConstraints() {
        imageView.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(4)
            $0.height.equalTo(166)
            $0.width.equalTo(166)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(4)
            $0.left.right.equalToSuperview().inset(8)
        }

        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(2)
            $0.left.right.equalToSuperview().inset(8)
        }

        priceLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(4)
            $0.left.equalToSuperview().inset(8)
        }

        actionButton.snp.makeConstraints {
            $0.top.equalTo(priceLabel.snp.bottom).offset(10)
            $0.left.right.bottom.equalToSuperview().inset(12)
            $0.height.equalTo(36)
            $0.width.equalTo(166)
        }
    }

}
