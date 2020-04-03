//
//  IntialScene.swift
//  ShapeFit
//
//  Created by Ankith on 3/25/20.
//  Copyright © 2020 Ankith. All rights reserved.
//

import SpriteKit
import SpriteKitExtensions
import StoreKit

class InitialScene: SKScene {
    private var animationAppear: (() -> Void)? = nil
    private var animationDisappear: (() -> Void)? = nil
    
    var gameScene: MainGameScene?
    private var score: Score?
    private var isInitialScene: Bool {
        get {
            return self.score == nil
        }
    }
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        animationAppear?()
        defer {
            if gameScene == nil {
                AppCache.instance.initializeGameTextures(with: MainGameScene.calculateSceneSize(view.frame.size))
                gameScene = MainGameScene()
            }
            
            if AppPersistence.highScorePoints > 10 && AppPersistence.matchesPlayedSinceLaunch > 6 {
                SKStoreReviewController.requestReview()
            }
        }
    }
    
    override func willMove(from view: SKView) {
        super.willMove(from: view)
        animationDisappear?()
    }
    
    init(score: Score?) {
        self.score = score
        let newSize = InitialScene.calculateSceneSize()
        super.init(size: newSize)
        GCHelper.sharedInstance.authenticateLocalUser()
        
        if let score = score { AppPersistence.saveNewScore(score) }
        
        backgroundColor = .black
        AppCache.instance.initializeInitialScreenBackgroundTexture(screenSize: newSize)
        
        let gradientNode1 = SKSpriteNode(texture: AppCache.instance.initialScreenBackgroundTexture)
        gradientNode1.position = CGPoint(x: newSize.width/2, y: newSize.height/2)
        gradientNode1.position.y += newSize.height/4
        gradientNode1.alpha = 1
        gradientNode1.zPosition = 1
        addChild(gradientNode1)
        
        let gradientNode2 = SKSpriteNode(color: .darkerBlack, size: CGSize(width: newSize.width, height: newSize.height/2))
        gradientNode2.position = CGPoint(x: newSize.width/2, y: newSize.height/2)
        gradientNode2.position.y -= newSize.height/4
        gradientNode2.alpha = 1
        gradientNode2.zPosition = 390
        addChild(gradientNode2)
        
        let isiPad = UIDevice.current.userInterfaceIdiom == .pad
        let iPadSize = CGSize(width: 326, height: 54)
        let iPhoneSize = CGSize(width: 216, height: 30)
        let deviceSize = (isiPad ? iPadSize : iPhoneSize)
        let margin = SKSpriteNode(color: .clear, size: deviceSize)
        
        let circlesStack = StackNode(size: deviceSize, fillMode: .horizontal)
        circlesStack.add(node: playButton)
        circlesStack.add(node: shareButton)
        circlesStack.reloadStack()
        
        let squaresStack = StackNode(size: deviceSize, fillMode: .horizontal)
        squaresStack.add(node: leaderboardButton)
        squaresStack.add(node: soundButton)
        squaresStack.add(node: rateButton)
        squaresStack.reloadStack()
        
        let bottomStack = StackNode(length: deviceSize.width, fillMode: .vertical)
        bottomStack.add(node: circlesStack)
        bottomStack.add(node: margin)
        bottomStack.add(node: squaresStack)
        bottomStack.add(node: margin.copy() as! SKNode)
        bottomStack.add(node: margin.copy() as! SKNode)
        if AppDefines.Constants.isiPhoneX { bottomStack.add(node: margin.copy() as! SKNode) }
        bottomStack.reloadStack()
        
        bottomStack.position = CGPoint(x: newSize.width/2, y: bottomStack.size.height/2)
        bottomStack.zPosition = 1000
        addChild(bottomStack)
        
        
        let multiplier: CGFloat = isiPad ? 30 : 20
        scoreStorage.alpha = 0
        scoreStorage.setScore(self.score ?? Score(points: 0))
        
        let topStack = StackNode(length: newSize.width, fillMode: .vertical)
        topStack.position = CGPoint(x: newSize.width/2, y: newSize.height/2)
        topStack.position.y += newSize.height/4 - multiplier/2
        topStack.zPosition = 400
        topStack.add(node: bannerLogo)
        topStack.add(node: scoreStorage)
        topStack.reloadStack()
        addChild(topStack)
        
        tutorialButton.position = CGPoint(x: newSize.width - tutorialButton.size.width/2, y: newSize.height - tutorialButton.size.height/2)
        tutorialButton.zPosition = 500
        tutorialButton.alpha = 0
        addChild(tutorialButton)
        
        let track = SKSpriteNode(color: .white, size: CGSize(width: newSize.width + 10, height: multiplier))
        track.position = CGPoint(x: newSize.width/2, y: newSize.height/2)
        track.position.y -= multiplier/2
        track.zPosition = 400
        addChild(track)
        
        animationAppear = { [weak self] in
            if let strongSelf = self {
                let start1 = bottomStack.position - CGPoint(x: 0 , y: 2 * strongSelf.convert(.zero, from: bottomStack).y)
                let ef1 = SKTMoveEffect(node: bottomStack, duration: 0.8, startPosition: start1, endPosition: bottomStack.position)
                ef1.timingFunction = SKTTimingFunctionBounceEaseOut
                bottomStack.run(.actionWithEffect(ef1))
                
                let logo = strongSelf.bannerLogo
                let start2 = logo.position + CGPoint(x: 0, y: 2 * (strongSelf.size.height - strongSelf.convert(.zero, from: logo).y))
                let ef2 = SKTMoveEffect(node: logo, duration: 0.8, startPosition: start2, endPosition: logo.position)
                ef2.timingFunction = SKTTimingFunctionBounceEaseOut
                logo.run(.actionWithEffect(ef2))
                
                strongSelf.scoreStorage.run(.appearAnimated(strongSelf.scoreStorage, time: 0.9, scale: 1))
                strongSelf.tutorialButton.run(.appearAnimated(strongSelf.tutorialButton, time: 0.8, scale: 1))
            }
        }
        
        animationDisappear = { [weak self] in
            if let strongSelf = self {
                let end1 = bottomStack.position - CGPoint(x: 0 , y: 2 * strongSelf.convert(.zero, from: bottomStack).y)
                let ef1 = SKTMoveEffect(node: bottomStack, duration: 0.2, startPosition: bottomStack.position, endPosition: end1)
                ef1.timingFunction = SKTTimingFunctionExponentialEaseIn
                bottomStack.run(.actionWithEffect(ef1))
                
                let logo = strongSelf.bannerLogo
                let end2 = logo.position + CGPoint(x: 0, y: 2 * (strongSelf.size.height - strongSelf.convert(.zero, from: logo).y))
                let ef2 = SKTMoveEffect(node: logo, duration: 0.2, startPosition: logo.position, endPosition: end2)
                ef2.timingFunction = SKTTimingFunctionExponentialEaseIn
                logo.run(.actionWithEffect(ef2))
                
                strongSelf.scoreStorage.run(.disappearAnimated(strongSelf.scoreStorage, time: 0.3))
                strongSelf.tutorialButton.run(.disappearAnimated(strongSelf.tutorialButton, time: 0.16))
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func calculateSceneSize(_ size: CGSize? = nil) -> CGSize {
        let size = size ?? AppDelegate.gameViewController.gameView.frame.size

        let defaultHeight: CGFloat = (AppDefines.Constants.isiPad ? 1024 : (AppDefines.Constants.isiPhoneX ? 800 : 640))
        let const = defaultHeight / size.height
        return CGSize(width: const * size.width, height: defaultHeight)
    }
    
    private func removeUIandPresentScene(_ scene:SKScene) {
        func present() {
            AppDelegate.gameViewController.gameView.presentScene(scene, transition: AppDefines.Transition.toGame)
        }
        
        if let animation = animationDisappear {
            animation()
            afterDelay(0.36) { present() }
        } else {
            present()
        }
    }
    
    // MARK: Buttons and banners
    
    private lazy var bannerLogo: SKSpriteNode = SKSpriteNode(texture: AppCache.instance.interfaceAtlas.textureNamed("shapefit_logo"))
    private lazy var scoreStorage: ScoreStorage = ScoreStorage(texture: AppCache.instance.interfaceAtlas.textureNamed("score_storage"))
    
    private lazy var playButton: Button = {
        let bt = Button(normalTexture: AppCache.instance.interfaceAtlas.textureNamed("bt_play_n"),
                          highlightedTexture: AppCache.instance.interfaceAtlas.textureNamed("bt_play_h"))
        
        bt.addClosure(.touchUpInside, target: self, closure: { (currentScene, sender) -> () in
            let scene = currentScene.gameScene ?? MainGameScene()
            currentScene.removeUIandPresentScene(scene)
        })
        return bt
    }()
    
    private lazy var tutorialButton: Button = {
        let bt = Button(size: CGSize(width: 52, height: 52), normalColor: .clear, highlightedColor: nil)
        bt.setNormalStateLabelText("?")
        bt.setHighlightedStateSingleLabelText("?")
        bt.setAllStatesLabelFontName(AppDefines.FontName.defaultLight)
        bt.setAllStatesLabelFontSize(24)
        bt.setHighlightedStateSingleLabelFontColor(SKColor.white.withAlphaComponent(0.7))
        
        bt.addClosure(.touchUpInside, target: self, closure: { (currentScene, sender) -> () in
            let sc = currentScene.score
            AppPersistence.alreadyPlayTutorial = false
            let scene = MainGameScene()
            currentScene.removeUIandPresentScene(scene)
        })
        return bt
    }()
    
    private lazy var leaderboardButton: Button = {
        let bt = Button(normalTexture: AppCache.instance.interfaceAtlas.textureNamed("bt_leaderboard_n"),
                          highlightedTexture: AppCache.instance.interfaceAtlas.textureNamed("bt_leaderboard_h"))
        
        bt.addClosure(.touchUpInside, target: self, closure: { (target, sender) -> () in
            let sc = target.score
            GCHelper.sharedInstance.showGameCenter(AppDelegate.gameViewController, viewState: .leaderboards)
        })
        return bt
    }()
    
    private lazy var shareButton: Button = {
        let bt = Button(normalTexture: AppCache.instance.interfaceAtlas.textureNamed("bt_share_n"),
                          highlightedTexture: AppCache.instance.interfaceAtlas.textureNamed("bt_share_h"))
        
        bt.addClosure(.touchUpInside, target: self, closure: { (currentScene, sender) -> () in
            var objectsToShare: [Any] = []
            
            if let score = currentScene.score {
                let pointsMessage = (score.points == 1 ? "SHARE_MESSAGE_COMPLETE_POINT" : "SHARE_MESSAGE_COMPLETE_POINTS")
                let textToShare = String(format:NSLocalizedString("SHARE_MESSAGE_COMPLETE", comment: ""), score.points, NSLocalizedString(pointsMessage, comment: ""), score.highScorePoints())
                objectsToShare.append(textToShare)
            } else {
                let textToShare = String(format:NSLocalizedString("SHARE_MESSAGE_TOP", comment: "message send when shared"), AppPersistence.highScorePoints)
                objectsToShare.append(textToShare)
            }
            
            let shareImageSize = CGSize(width: 600, height: 400)
            let shareImageView = SKView(frame: CGRect(origin: .zero, size: shareImageSize))
            
            let shareImageOverlayView = UIImageView(image: UIImage(named: "bg1"))
            shareImageOverlayView.frame = shareImageView.frame
            shareImageOverlayView.contentMode = .scaleAspectFill
            shareImageOverlayView.isUserInteractionEnabled = false
            shareImageOverlayView.alpha = 0.16
            shareImageView.addSubview(shareImageOverlayView)
            
            let shareImageScene = ShareImageScene(size: shareImageSize, score: currentScene.score)
            shareImageView.presentScene(shareImageScene)
            if let shareImage = shareImageView.asImage(.current) {
                objectsToShare.append(shareImage)
            }
            
            objectsToShare.append(AppDefines.Constants.appStoreLink)
            
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            
            let gameView = AppDelegate.gameViewController.gameView
            activityVC.popoverPresentationController?.sourceView = gameView
            activityVC.popoverPresentationController?.sourceRect = CGRect(origin: CGPoint(x: gameView.frame.size.width/2, y: gameView.frame.size.height/2), size: .zero)
            activityVC.popoverPresentationController?.permittedArrowDirections = .up
            
            defer {
                AppDelegate.gameViewController.present(activityVC, animated: true, completion: nil)
            }
        })
        return bt
    }()
    
    private lazy var rateButton: Button = {
        let bt = Button(normalTexture: AppCache.instance.interfaceAtlas.textureNamed("bt_rate_n"),
                          highlightedTexture: AppCache.instance.interfaceAtlas.textureNamed("bt_rate_h"))
        
        bt.addClosure(.touchUpInside, target: self, closure: { (target, sender) -> () in
            let sc = target.score
            
            let alert = UIAlertController(title: NSLocalizedString("RATE_ALERT_TITLE", comment: ""), message: NSLocalizedString("RATE_ALERT_MESSAGE", comment: ""), preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: NSLocalizedString("RATE_ALERT_YES", comment: ""), style: .default, handler: { (action:UIAlertAction) -> Void in
                
                let appID = AppDefines.Constants.appStoreID
                let rateURLString = "itms-apps://itunes.apple.com/us/app/\(appID)?action=write-review"

                if let url = URL(string: rateURLString) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }))
            
            alert.addAction(UIAlertAction(title: NSLocalizedString("RATE_ALERT_CANCEL", comment: ""), style: .cancel, handler: nil))
            AppDelegate.gameViewController.present(alert, animated: true, completion: nil)
        })
        return bt
    }()
    
    private lazy var soundButton: Switch = {
        let sw = Switch(normalTexture: AppCache.instance.interfaceAtlas.textureNamed("bt_sound_on_n"),
                          selectedTexture: AppCache.instance.interfaceAtlas.textureNamed("bt_sound_off_n"))
        sw.highlightedStateMultiTextureFromNormal = AppCache.instance.interfaceAtlas.textureNamed("bt_sound_on_h")
        sw.highlightedStateMultiTextureFromSelected = AppCache.instance.interfaceAtlas.textureNamed("bt_sound_off_h")
        
        sw.selected = !SKAction.shouldPlaySound()
        sw.addClosure(.touchUpInside, target: self, closure: { (s, sender) -> () in
            SKAction.saveNewSoundEffectsSettings(!sender.selected)
        })
        return sw
    }()
    
    #if SNAPSHOT
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let scene = gameScene ?? GameScene()
        AppDelegate.gameViewController.gameView.presentScene(scene, transition: AppDefines.Transition.toGame)
    }
    #endif
}
