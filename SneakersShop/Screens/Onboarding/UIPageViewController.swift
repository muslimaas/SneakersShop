//
//  UIPageViewController.swift
//  SneakersShop
//
//  Created by Muslima Sandybay on 13.01.2026.
//

import UIKit

final class OnboardingViewController: UIViewController {

    private var pageViewController: UIPageViewController!
    private var pages: [OnboardingItemViewController] = []
    private var i = 0
    var onFinish: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPages()
        setupPageViewController()
    }

    private func setupPages() {
        pages = onboardingPages.enumerated().map { index, model in
            let vc = OnboardingItemViewController(model: model)
            vc.onNextTapped = { [weak self] in
                self?.goToNextPage()
            }

            return vc
        }
    }
    
    private func setupPageViewController() {
        pageViewController = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal
        )

        pageViewController.dataSource = self
        pageViewController.delegate = self

        guard let first = pages.first else { return }

        pageViewController.setViewControllers(
            [first],
            direction: .forward,
            animated: false
        )

        pages[0].updatePageControl(current: 0, total: pages.count)
        pages[0].updateButtonTitle(pages.count == 1 ? "Finish" : "Next")

        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)

        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pageViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            pageViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pageViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func goToNextPage() {
        if i == pages.count - 1 {
            onFinish?()
        } else {
            i += 1
            pageViewController.setViewControllers([pages[i]], direction: .forward, animated: true, completion: nil
            )
            pages[i].updatePageControl(current: i, total: pages.count)
            pages[i].updateButtonTitle(i == pages.count - 1 ? "Finish" : "Next")
        }
        
    }
}

extension OnboardingViewController: UIPageViewControllerDataSource {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(where: { $0 === viewController }) else { return nil }
        let prevIndex = currentIndex - 1
        guard prevIndex >= 0 else { return nil }
        return pages[prevIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(where: { $0 === viewController }) else { return nil }
        let nextIndex = currentIndex + 1
        guard nextIndex < pages.count else { return nil }
        return pages[nextIndex]
    }
}

extension OnboardingViewController: UIPageViewControllerDelegate {

    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard
            completed,
            let visibleVC = pageViewController.viewControllers?.first,
            let index = pages.firstIndex(where: { $0 === visibleVC })
        else { return }

        i = index
        pages[i].updateButtonTitle(i == pages.count - 1 ? "Finish" : "Next")
        pages[i].updatePageControl(current: i, total: pages.count)
    }
}
