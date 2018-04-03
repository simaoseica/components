//
//  AppDelegate.swift
//  Component
//
//  Created by Simão Seiça  on 03/04/2018.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        self.window = UIWindow(frame: UIScreen.main.bounds)

        self.window?.rootViewController = ConcreteViewController()
        self.window?.makeKeyAndVisible()

        return true
    }

}

