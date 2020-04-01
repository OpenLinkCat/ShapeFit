//
//  AppDelegate.swift
//  ShapeFit
//
//  Created by Ankith on 3/22/20.
//  Copyright © 2020 Ankith. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    static var instance: AppDelegate { return UIApplication.shared.delegate as! AppDelegate }
    static var gameViewController: MainGameViewController { return instance.gameViewController }
    
    var window: UIWindow?
    private lazy var gameViewController = MainGameViewController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        #if DEBUG && !SNAPSHOT
            BUILD_MODE = .debug
        #else
            BUILD_MODE = .release
        #endif
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.backgroundColor = UIColor.white
        window!.makeKeyAndVisible()
        window!.rootViewController = ScreenViewController()
        return true
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        AppPersistence.matchesPlayedSinceLaunch = 0
        if let gameScene = gameViewController.gameView.scene as? MainGameScene {
            gameScene.updateTimer.lap()
        }
    }
}
