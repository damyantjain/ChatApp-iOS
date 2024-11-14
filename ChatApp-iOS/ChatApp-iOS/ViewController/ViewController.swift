//
//  ViewController.swift
//  ChatApp-iOS
//
//  Created by Damyant Jain on 11/4/24.
//

import FirebaseAuth
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if Auth.auth().currentUser == nil {
            navigateToLoginScreen()
        } else {
            navigateToLandingScreen()
        }
    }

    private func navigateToLandingScreen() {
        let landingVC = LandingViewController()
        navigationController?.setViewControllers([landingVC], animated: true)
    }

    private func navigateToLoginScreen() {
        let loginVC = LoginViewController()
        navigationController?.setViewControllers([loginVC], animated: true)
    }
}
