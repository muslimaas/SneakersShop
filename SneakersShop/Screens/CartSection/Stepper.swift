//
//  Stepper.swift
//  SneakersShop
//
//  Created by Muslima Sandybay on 22.01.2026.
//


import SnapKit
import UIKit

final class Stepper: UIControl {
    var currentValue = 1 {
        didSet {
            if currentValue < 1 {
                currentValue = 1
            }
            currentStepValueLabel.text = "\(currentValue)"
        }
    }

    private lazy var decreaseButton: UIButton = {
       let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.setTitle("-", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }()

    private lazy var increaseButton: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.setTitleColor(.white, for: .normal)
        return button
    }()

    private lazy var currentStepValueLabel: UILabel = {
        var label = UILabel()
        label.textColor = .white
        label.text = "\(currentValue)"
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 15, weight: UIFont.Weight.regular)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }

    private func setupUI() {
        backgroundColor = .black
        layer.cornerRadius = 16
        clipsToBounds = true
        addSubview(decreaseButton)
        addSubview(increaseButton)
        addSubview(currentStepValueLabel)

        decreaseButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(8)
        }

        increaseButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-8)
        }

        currentStepValueLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }

    @objc private func buttonAction(_ sender: UIButton) {
        switch sender {
        case decreaseButton:
            currentValue -= 1
        case increaseButton:
            currentValue += 1
        default:
            break
        }

        sendActions(for: .valueChanged)
    }
}
