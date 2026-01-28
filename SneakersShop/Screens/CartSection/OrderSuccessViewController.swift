import UIKit
import SnapKit

final class OrderSuccessViewController: UIViewController {


    private let dimView = UIView()
    private let containerView = UIView()

    private let backgroundVectorImageView = UIImageView()
    private let shoesImageView = UIImageView()

    private let titleLabel = UILabel()
    private let actionButton = UIButton(type: .system)

    var onClose: (() -> Void)?
    
    


    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        animateAppearance()
    }


    private func setupUI() {
        view.backgroundColor = .clear

        dimView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        view.addSubview(dimView)
        dimView.snp.makeConstraints { $0.edges.equalToSuperview() }

        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 24
        containerView.clipsToBounds = true
        view.addSubview(containerView)

        containerView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.63)
        }

        backgroundVectorImageView.image = UIImage(named: "vector")
        backgroundVectorImageView.contentMode = .scaleAspectFill
        backgroundVectorImageView.clipsToBounds = true


        shoesImageView.image = UIImage(named: "shoes")
        shoesImageView.contentMode = .scaleAspectFit
        shoesImageView.clipsToBounds = true

        titleLabel.text = "Your order is successfully placed. Thanks!"
        titleLabel.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0


        actionButton.setTitle("Get back to shopping", for: .normal)
        actionButton.backgroundColor = .black
        actionButton.setTitleColor(.white, for: .normal)
        actionButton.layer.cornerRadius = 32
        actionButton.addTarget(self, action: #selector(close), for: .touchUpInside)

        containerView.addSubview(shoesImageView)
        containerView.addSubview(backgroundVectorImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(actionButton)
        containerView.clipsToBounds = true


        backgroundVectorImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(-40)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(200)
        }


        shoesImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(40)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(210)
            $0.height.equalTo(278)
        }
        actionButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(24)
            $0.height.equalTo(54)
        }

        titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(actionButton.snp.top).offset(-24)
        }

       
    }


    private func animateAppearance() {
        containerView.transform = CGAffineTransform(translationX: 0, y: 300)
        dimView.alpha = 0

        UIView.animate(withDuration: 0.35, delay: 0, options: [.curveEaseOut]) {
            self.containerView.transform = .identity
            self.dimView.alpha = 0.4
        }
    }


    @objc private func close() {
        dismiss(animated: true) {
            self.onClose?()
        }
    }
}
