//
//  ScreenViewController.swift
//  ShapeFit
//
//  Created by Ankith on 3/25/20.
//  Copyright © 2020 Ankith. All rights reserved.
//

import UIKit

class ScreenViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        GCHelper.sharedInstance.authenticateLocalUser()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        AppCache.instance.resetSounds(initializeAfter: true)
        AppCache.instance.initializeInitialScreenBackgroundTexture(screenSize: InitialScene.calculateSceneSize(self.view.frame.size))
        
        delay(0.3) {
            let vc = AppDelegate.mainGameViewController
            vc.modalTransitionStyle = .crossDissolve
            self.present(vc, animated: true, completion: nil)
        }
    }
}
