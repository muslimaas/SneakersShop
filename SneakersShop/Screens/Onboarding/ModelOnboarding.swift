//
//  OnboardingViewController.swift
//  SneakersShop
//
//  Created by Muslima Sandybay on 13.01.2026.
//

import UIKit

struct OnboardingModel {
    let imageName: String
    let title: String
    let subtitle: String
}

let onboardingPages: [OnboardingModel] = [
    OnboardingModel(
        imageName: "Img",
        title: "Find your sneakers",
        subtitle: "Discover the latest sneaker collections all in one place."
    ),
    OnboardingModel(
        imageName: "Image",
        title: "Fast shipping",
        subtitle: "Get all of your desired sneakers in one place."
    ),
    OnboardingModel(
        imageName: "Image 1",
        title: "Start shopping",
        subtitle: "Choose your style and order sneakers with confidence."
    )
]
