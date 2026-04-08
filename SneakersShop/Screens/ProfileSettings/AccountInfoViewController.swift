import UIKit
import SnapKit
import FirebaseAuth
import FirebaseFirestore

final class AccountInfoViewController: UIViewController {

    private let usernameField = UITextField()
    private let oldPasswordField = UITextField()
    private let newPasswordField = UITextField()
    private let saveButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Account Information"
        view.backgroundColor = .systemBackground

        setupUI()
        loadProfile()
    }
}

private extension AccountInfoViewController {

    func setupUI() {

        usernameField.placeholder = "Username"

        oldPasswordField.placeholder = "Old password"
        oldPasswordField.isSecureTextEntry = true

        newPasswordField.placeholder = "New password"
        newPasswordField.isSecureTextEntry = true

        saveButton.setTitle("Save changes", for: .normal)
        saveButton.backgroundColor = .black
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.layer.cornerRadius = 28

        view.addSubview(usernameField)
        view.addSubview(oldPasswordField)
        view.addSubview(newPasswordField)
        view.addSubview(saveButton)

        usernameField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(50)
        }

        oldPasswordField.snp.makeConstraints {
            $0.top.equalTo(usernameField.snp.bottom).offset(12)
            $0.leading.trailing.height.equalTo(usernameField)
        }

        newPasswordField.snp.makeConstraints {
            $0.top.equalTo(oldPasswordField.snp.bottom).offset(12)
            $0.leading.trailing.height.equalTo(usernameField)
        }

        saveButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(56)
        }

        saveButton.addTarget(self,
                             action: #selector(saveChanges),
                             for: .touchUpInside)
    }
}

private extension AccountInfoViewController {

    func loadProfile() {
        ProfileService.shared.fetchProfile { result in
            DispatchQueue.main.async {
                if case .success(let (username, _)) = result {
                    self.usernameField.text = username
                }
            }
        }
    }

    @objc func saveChanges() {

        guard let username = usernameField.text else { return }

        ProfileService.shared.fetchProfile { result in
            if case .success(let (_, currentSize)) = result {
                ProfileService.shared.saveProfile(username: username,
                                                  shoeSize: currentSize) { _ in }
            }
        }

        if let newPassword = newPasswordField.text,
           !newPassword.isEmpty {

            Auth.auth().currentUser?
                .updatePassword(to: newPassword) { error in
                    if let error = error {
                        print(error)
                    }
                }
        }

        navigationController?.popViewController(animated: true)
    }
}
