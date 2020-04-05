//
//  ScreenViewController.swift
//  ShapeFit
//
//  Created by Ankith on 3/25/20.
//  Copyright © 2020 Ankith. All rights reserved.
//

import UIKit
import GoogleMobileAds
class ScreenViewController: UIViewController, GADInterstitialDelegate {
    var interstitial: GADInterstitial!
    override func viewDidLoad() {
        super.viewDidLoad()
        GCHelper.sharedInstance.authenticateLocalUser()
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910")
        let request = GADRequest()
        interstitial.load(request)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        AppCache.instance.resetSounds(initializeAfter: true)
        AppCache.instance.initializeInitialScreenBackgroundTexture(screenSize: InitialScene.calculateSceneSize(self.view.frame.size))
        
        delay(0.3) {
            let vc = AppDelegate.gameViewController
            vc.modalTransitionStyle = .crossDissolve
            self.present(vc, animated: true, completion: nil)
        }
    }
    func createAd() -> GADInterstitial {
        // Don't have to specify device identifiers for IOS Simulators, but need for physical devices (ignore warning for simulator)

        interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910")
        interstitial.delegate = self
        let request = GADRequest()
        interstitial.load(request)
        return interstitial
    }
    
    func gameEndedPresentAdAndInitialScene(_ scene: SKScene) {
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910")
        interstitial.delegate = self
        let request = GADRequest()
        interstitial.load(request)
        if interstitial != nil {
            if (interstitial.isReady == true){
                interstitial.present(fromRootViewController:self)
                AppDelegate.gameViewController.gameView.presentScene(scene, transition: AppDefines.Transition.toInitial)
            } else {
                print("ad wasn't ready1")
                interstitial = createAd()
                AppDelegate.gameViewController.gameView.presentScene(scene, transition: AppDefines.Transition.toInitial)
            }
        } else {
            print("ad wasn't ready2")
            interstitial = createAd()
            AppDelegate.gameViewController.gameView.presentScene(scene, transition: AppDefines.Transition.toInitial)
        }
        
    }
    
}
