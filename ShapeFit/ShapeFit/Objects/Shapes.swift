//
//  Shapes.swift
//  ShapeFit
//
//  Created by Ankith on 3/22/20.
//  Copyright © 2020 Ankith. All rights reserved.
//

import SpriteKit

class Shape: SKSpriteNode {
    // Play with CGSize numbers
    // Play with time intervals
    static let defaultsize = CGSize(width: 60, height: 60)
    var timeToDisappear: TimeInterval = 0
    var disappearingTime: TimeInterval = 0.2
    var moveTime: TimeInterval = 0.5
    var failureNoticeTime: TimeInterval = 0.2
    var shapeCreationTime: TimeInterval = 0.3
    
    enum Actions {
        static let GameEnd = "Game End"
        static let move = "move"
    }
    
    
    
}
