//
//  MainGameViewController.swift
//  ShapeFit
//
//  Created by Ankith on 3/25/20.
//  Copyright © 2020 Ankith. All rights reserved.
//

import UIKit
import SpriteKit
import SpriteKitExtensions
import GoogleMobileAds

class MainGameViewController: UIViewController, GADInterstitialDelegate {
    var gameView: SKView { return view as! SKView }
    var interstitial: GADInterstitial!
    override func loadView() {
        let skView = SKView()
        skView.frame = UIScreen.main.bounds
        skView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        skView.showsFPS = BUILD_MODE == .debug
        skView.showsNodeCount = BUILD_MODE == .debug
        skView.showsPhysics = BUILD_MODE == .debug
        skView.ignoresSiblingOrder = true
        view = skView
        isModalInPresentation = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interstitial = createAndLoadInterstitial()
        NotificationCenter.default.addObserver(self, selector: #selector(self.showInterstitial), name:NSNotification.Name(rawValue: "showInterAd"), object: nil);
        Control.defaultTouchUpSoundFileName = "button_up.wav"
        Control.defaultTouchDownSoundFileName = "button_down.wav"
        _ = SKAction.reloadSoundEffectsSettings()
        
        let overlayView = UIImageView(image: UIImage(named: "bg1"))
        overlayView.contentMode = .scaleAspectFill
        overlayView.isUserInteractionEnabled = false
        overlayView.alpha = 0.13
        view.addSubview(overlayView)
        
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        overlayView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        overlayView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        overlayView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        overlayView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        #if SNAPSHOT
            AppPersistence.resetUserDefaults()
            AppPersistence.highScorePoints = 77
            let scene = InitialScene(score: Score(points: 14))
            gameView.presentScene(scene)
        #else
            let scene = InitialScene(score: nil)
            gameView.presentScene(scene)
        #endif
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        GCHelper.sharedInstance.authenticateLocalUser()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        if let scene = gameView.scene as? InitialScene {
            scene.gameScene = nil
        }
    }
    @objc func showInterstitial(){
        if (interstitial!.isReady) {
            self.interstitial.present(fromRootViewController: self)
        }else{
            print("ad not ready?")
        }
    }

    func createAndLoadInterstitial() -> GADInterstitial {
        print("making ad")
        let interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/5135589807")
        interstitial.delegate = self
        let request = GADRequest()
        interstitial.load(request)
        return interstitial
    }

    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        interstitial = createAndLoadInterstitial()
    }
    
}
