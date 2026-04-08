import UIKit
import SnapKit

final class ProfileViewController: UIViewController {

    weak var coordinator: ProfileCoordinator?

    private let stackView = UIStackView()
    private let signOutButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        view.backgroundColor = .systemGray6

        setupLayout()
        setupRows()
        setupSignOut()
    }
}

private extension ProfileViewController {

    func setupLayout() {
        view.addSubview(stackView)
        view.addSubview(signOutButton)

        stackView.axis = .vertical
        stackView.spacing = 12

        stackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        signOutButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(56)
        }
    }

    func setupRows() {

        let account = ProfileRowView(title: "Account Information")
        account.addTarget(self, action: #selector(openAccount), for: .touchUpInside)

        let shoeSize = ProfileRowView(title: "Shoe size")
        shoeSize.addTarget(self, action: #selector(openShoeSize), for: .touchUpInside)

        let faq = ProfileRowView(title: "FAQ",
                                 systemImage: "arrow.up.right.square")
        faq.addTarget(self, action: #selector(openFAQ), for: .touchUpInside)

        stackView.addArrangedSubview(account)
        stackView.addArrangedSubview(shoeSize)
        stackView.addArrangedSubview(faq)
    }

    func setupSignOut() {
        signOutButton.setTitle("Sign out", for: .normal)
        signOutButton.setTitleColor(.white, for: .normal)
        signOutButton.backgroundColor = .black
        signOutButton.layer.cornerRadius = 28

        signOutButton.addTarget(self,
                                action: #selector(didTapSignOut),
                                for: .touchUpInside)
    }
}

private extension ProfileViewController {

    @objc func openAccount() {
        coordinator?.openAccountInfo()
    }

    @objc func openShoeSize() {
        coordinator?.openShoeSize()
    }

    @objc func openFAQ() {
        if let url = URL(string: "https://www.adidas.com/us/blog/968383-how-to-measure-shoe-size") {
            coordinator?.openWeb(url: url)
        }
    }

    @objc func didTapSignOut() {

        let alert = UIAlertController(
            title: nil,
            message: "Are you sure you want to sign out?",
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Confirm",
                                      style: .destructive) { _ in
            self.coordinator?.logout()
        })

        present(alert, animated: true)
    }
}
