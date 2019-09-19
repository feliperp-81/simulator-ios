//
//  AppDelegate.swift
//  simulator
//
//  Created by Felipe Rodrigues on 17/09/19.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        updateAppearence()

        return true
    }

    private func updateAppearence() {
        UINavigationBar.appearance().tintColor = UIColor.black
    }
}
