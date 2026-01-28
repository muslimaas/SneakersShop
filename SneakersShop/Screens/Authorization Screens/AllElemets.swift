import UIKit

final class BigButtonView: UIView {

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
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 32
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        button.addTarget(self, action: #selector(didTap), for: .touchUpInside)

        addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: topAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor),
            button.leadingAnchor.constraint(equalTo: leadingAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    func setTitle(_ title: String) {
        button.setTitle(title, for: .normal)
    }
    
    func BackColor(_ color: UIColor) {
        let titleColor: UIColor = color == .white ? .black : .white
        button.backgroundColor = color
        button.setTitleColor(titleColor, for: .normal)
    }

    @objc private func didTap() {
        onTap?()
    }

}

final class BigTitle: UIView {
    

    let label: UILabel = {
        let label = UILabel()
        label.text = "some text"
        label.textColor = .black
        label.font = .systemFont(ofSize: 28, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
}
