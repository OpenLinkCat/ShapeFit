//
//  TextureActions.swift
//  ShapeFit
//
//  Created by Ankith on 3/24/20.
//  Copyright © 2020 Ankith. All rights reserved.
//

import SpriteKit

extension SKAction {
    static func textureActions(_ originalTextureShape: ShapeType, duration: TimeInterval, availableTextureShape: [ShapeType]) -> SKAction {
        let remainingTextures = availableTextureShape.filter { $0 != originalTextureShape }
        var interElapsedTime: CGFloat = 0
        return .customAction(withDuration: duration) {(node, elapsedTime) in
            if elapsedTime < CGFloat(duration) {
                if elapsedTime >= interElapsedTime {
                    interElapsedTime += CGFloat(duration)/3.4
                    (node as! SKSpriteNode).texture = AppCache.instance.gradient(shape: remainingTextures[Int.random(within: 0..<remainingTextures.count)])
                }
            } else {
                (node as! SKSpriteNode).texture = nil
                (node as! SKSpriteNode).color = .darkerBlack
            }
        }
    }
}
