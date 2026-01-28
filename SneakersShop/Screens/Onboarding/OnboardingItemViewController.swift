//
//  Untitled.swift
//  SneakersShop
//
//  Created by Muslima Sandybay on 13.01.2026.
//
import UIKit

final class OnboardingItemViewController: UIViewController {

    private let model: OnboardingModel

    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let bottomContainerView = UIView()
    private let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterial))
    private let textStackView = UIStackView()
    private let nextButton = UIButton(type: .system)
    let pageControl = UIPageControl()
    var onNextTapped: (() -> Void)?

    init(model: OnboardingModel) {
        self.model = model
        
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        setupLayout()
        nextButton.addTarget(self, action: #selector(nextTapped), for: .touchUpInside)

    }
    @objc private func nextTapped() {
        onNextTapped?()
    }
    func updateButtonTitle(_ title: String) {
        nextButton.setTitle(title, for: .normal)
    }
    
    private func setupUI() {
            imageView.image = UIImage(named: model.imageName)
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true

            titleLabel.text = model.title
            titleLabel.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
            titleLabel.textAlignment = .center
            titleLabel.textColor = .white
            titleLabel.numberOfLines = 0

            subtitleLabel.text = model.subtitle
            subtitleLabel.font = UIFont.systemFont(ofSize: 17, weight: .regular)
            subtitleLabel.textAlignment = .center
            subtitleLabel.textColor = .white
            subtitleLabel.numberOfLines = 0
        
            bottomContainerView.backgroundColor = .black.withAlphaComponent(0.7)
            bottomContainerView.layer.cornerRadius = 12
            bottomContainerView.layer.masksToBounds = true

            blurView.translatesAutoresizingMaskIntoConstraints = false
            bottomContainerView.addSubview(blurView)
        
            textStackView.axis = .vertical
            textStackView.spacing = 16
            textStackView.alignment = .center
            textStackView.setCustomSpacing(40, after: pageControl)
        
            pageControl.isUserInteractionEnabled = false
            pageControl.currentPageIndicatorTintColor = .white
            pageControl.pageIndicatorTintColor = UIColor.white.withAlphaComponent(0.4)
        
            nextButton.backgroundColor = .black
            nextButton.setTitleColor(.white, for: .normal)
            nextButton.layer.cornerRadius = 32
            nextButton.layer.masksToBounds = true
            nextButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        }
    
    private func setupLayout() {
        [imageView, bottomContainerView, textStackView, titleLabel, subtitleLabel, nextButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        view.addSubview(imageView)
        view.addSubview(bottomContainerView)

        NSLayoutConstraint.activate([
            blurView.topAnchor.constraint(equalTo: bottomContainerView.topAnchor),
            blurView.leadingAnchor.constraint(equalTo: bottomContainerView.leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: bottomContainerView.trailingAnchor),
            blurView.bottomAnchor.constraint(equalTo: bottomContainerView.bottomAnchor)
        ])

        bottomContainerView.addSubview(textStackView)
        bottomContainerView.addSubview(nextButton)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        
        
        textStackView.addArrangedSubview(pageControl)
        textStackView.addArrangedSubview(titleLabel)
        textStackView.addArrangedSubview(subtitleLabel)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor),

            bottomContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.35),

            textStackView.topAnchor.constraint(equalTo: bottomContainerView.topAnchor, constant: 32),
            textStackView.leadingAnchor.constraint(equalTo: bottomContainerView.leadingAnchor, constant: 24),
            textStackView.trailingAnchor.constraint(equalTo: bottomContainerView.trailingAnchor, constant: -24),

            nextButton.bottomAnchor.constraint(equalTo: bottomContainerView.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            nextButton.centerXAnchor.constraint(equalTo: bottomContainerView.centerXAnchor),
            nextButton.widthAnchor.constraint(equalTo: bottomContainerView.widthAnchor, multiplier: 0.9),
            nextButton.heightAnchor.constraint(equalToConstant: 72)
        ])
    }
    func updatePageControl(current: Int, total: Int) {
        pageControl.numberOfPages = total
        pageControl.currentPage = current
    }
}

