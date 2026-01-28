import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get }
    var id: UUID { get }
    var onFinish: (() -> Void)? { get set }
    func start()
}

final class AppCoordinator: Coordinator {
    private let window: UIWindow
    let id: UUID = UUID()
    var onFinish: (() -> Void)? = nil
    let navigationController: UINavigationController
    private var childCoordinators: [UUID : Coordinator] = [:]

    init(window: UIWindow) {
        self.window = window
        navigationController = UINavigationController()
    }

    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        showMainCatalog()
    }
    

    private func showOnboarding() {
        let coordinator = OnboardingCoordinator(
            navigationController: navigationController
        )

        coordinator.onFinish = { [weak self] in
            self?.showAuth()
        }
        coordinateTo(coordinator)
    }
    
    
    private func showAuth() {
        let coordinator = AuthCoordinator(
            navigationController: navigationController
        )

        coordinator.onFinish = { [weak self] in
            self?.showMainCatalog()
        }
        coordinateTo(coordinator)
    }
    private func showMainCatalog() {
        let coordinator = MainTabBarCoordinator(
            navigationController: navigationController
        )
        coordinateTo(coordinator)
    }

    private func coordinateTo(_ coordinator: Coordinator) {
        var coordinator = coordinator
        let id  = coordinator.id
        let completion = coordinator.onFinish
        childCoordinators[id] = coordinator
        
        coordinator.onFinish = { [weak self] in
            completion?()
            
            self?.childCoordinators.removeValue(forKey: id)
        }
        
        coordinator.start()
    }

}

