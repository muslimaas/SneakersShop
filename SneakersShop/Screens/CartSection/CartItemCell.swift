import UIKit
import SnapKit

final class CartItemCell: UITableViewCell {

    var onIncrease: (() -> Void)?
    var onDecrease: (() -> Void)?
    var onDelete: (() -> Void)?

    private let cardView = UIView()
    private let productImageView = UIImageView()
    private let titleLabel = UILabel()
    private let priceLabel = UILabel()
    private let stepper = Stepper()
    private let descriptionLabel = UILabel()

    private var currentQuantity: Int = 1

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        productImageView.image = nil
    }

    private func setupUI() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear

        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = 4
        cardView.clipsToBounds = true

        contentView.addSubview(cardView)

        cardView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }

        productImageView.contentMode = .scaleAspectFit

        titleLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        priceLabel.font = .systemFont(ofSize: 12, weight: .bold)
        descriptionLabel.font = .systemFont(ofSize: 12, weight: .regular)
        descriptionLabel.textColor = .secondaryLabel

        cardView.addSubview(productImageView)
        cardView.addSubview(titleLabel)
        cardView.addSubview(descriptionLabel)
        cardView.addSubview(priceLabel)
        cardView.addSubview(stepper)

        productImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(140)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(21)
            $0.leading.equalTo(productImageView.snp.trailing).offset(16)
            $0.trailing.equalToSuperview().inset(16)
        }
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(3)
            $0.leading.equalTo(titleLabel)
            $0.trailing.equalToSuperview().inset(16)
        }

        priceLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(2)
            $0.leading.equalTo(titleLabel)
        }

        stepper.snp.makeConstraints {
            $0.top.equalTo(priceLabel.snp.bottom).offset(10)
            $0.leading.equalTo(titleLabel)
            $0.width.equalTo(166)
            $0.height.equalTo(36)
            $0.bottom.lessThanOrEqualToSuperview().inset(16)

        }

        stepper.addTarget(self, action: #selector(stepperChanged), for: .valueChanged)
    }

    func configure(with item: CartItem) {
        titleLabel.text = item.title
        descriptionLabel.text = item.description
        priceLabel.text = "$\(item.price * item.quantity)"

        currentQuantity = item.quantity
        stepper.currentValue = item.quantity

        if let url = URL(string: item.image) {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
                guard let data, let image = UIImage(data: data) else { return }
                DispatchQueue.main.async {
                    self?.productImageView.image = image
                }
            }.resume()
        }
    }

    @objc private func stepperChanged() {
        let newValue = stepper.currentValue

        if newValue > currentQuantity {
            onIncrease?()
        } else if newValue < currentQuantity {
            onDecrease?()
        }

        currentQuantity = newValue
    }
}
