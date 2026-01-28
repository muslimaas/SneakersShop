import UIKit

final class OnboardingCoordinator: Coordinator {

    let id = UUID()
    let navigationController: UINavigationController
    var onFinish: (() -> Void)?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = OnboardingViewController()
        vc.onFinish = { [weak self] in
            self?.onFinish?()
        }

        navigationController.pushViewController(vc, animated: false)
    }
    
}
