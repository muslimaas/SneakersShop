import UIKit
import SnapKit

final class ProfileRowView: UIControl {

    private let titleLabel = UILabel()
    private let iconView = UIImageView()

    init(title: String, systemImage: String = "chevron.right") {
        super.init(frame: .zero)

        backgroundColor = .secondarySystemGroupedBackground
        layer.cornerRadius = 16

        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: 16)
        titleLabel.numberOfLines = 0

        iconView.image = UIImage(systemName: systemImage)
        iconView.tintColor = .tertiaryLabel

        addSubview(titleLabel)
        addSubview(iconView)

        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(iconView.snp.leading).offset(-8)
        }

        iconView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(16)
        }

        snp.makeConstraints {
            $0.height.greaterThanOrEqualTo(56)
        }
    }

    required init?(coder: NSCoder) { fatalError() }

    override var isHighlighted: Bool {
        didSet {
            alpha = isHighlighted ? 0.6 : 1
        }
    }
}
