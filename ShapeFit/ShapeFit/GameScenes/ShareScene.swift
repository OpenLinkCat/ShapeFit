//
//  ShareScene.swift
//  ShapeFit
//
//  Created by Ankith on 3/28/20.
//  Copyright © 2020 Ankith. All rights reserved.
//

import SpriteKit
import SpriteKitExtensions

class ShareScene: SKScene {
    private let displayContent: StackNode!
    
    init(size: CGSize, score: Score?) {
        displayContent = StackNode(length: size.width, fillMode: .vertical)
        super.init(size: size)
        backgroundColor = .red
        
        let gradientNode = SKSpriteNode(texture: SKTexture(radialGradient: size, colors: [.purple, .darkPurple]))
        gradientNode.position = CGPoint(x: size.width/2, y: size.height/2)
        gradientNode.alpha = 1
        gradientNode.zPosition = 1
        addChild(gradientNode)
        
        let logo = SKSpriteNode(texture: SKTexture(imageNamed: "shapefit_logo_banner.png"))
        
        let scoreC = ScoreStorage(texture: SKTexture(imageNamed: "score_storage_banner.png"))
        scoreC.setScore(score ?? Score(points: 0))
        
        let str = NSLocalizedString("DOWNLOAD_BANNER", comment: "")
        let downl = SKSpriteNode(texture: SKTexture(imageNamed: str))

        
        displayContent.add(node: logo)
        displayContent.add(node: scoreC)
        displayContent.add(node: SKSpriteNode(color: .clear, size: CGSize(width: 10, height: 26)))
        displayContent.add(node: downl)
        displayContent.reloadStack()
        displayContent.zPosition = 300
        displayContent.position = CGPoint(x: size.width/2, y: size.height/2)
    
        addChild(displayContent)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
