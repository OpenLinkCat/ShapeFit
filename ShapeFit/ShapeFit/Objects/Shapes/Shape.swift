//
//  Shapes.swift
//  ShapeFit
//
//  Created by Ankith on 3/22/20.
//  Copyright © 2020 Ankith. All rights reserved.
//

import SpriteKit

class Shape: SKSpriteNode {
    private let shapeColor: SKColor
    
    
    // Play with CGSize numbers
    // Play with time intervals
    
    static let defaultSize = CGSize(width: 60, height: 60)
    var timeToDisappear: TimeInterval = 0
    var disappearingTime: TimeInterval = 0.2
    var moveTime: TimeInterval = 0.5
    var failureNoticeTime: TimeInterval = 0.2
    var shapeCreationTime: TimeInterval = 0.3
    
    enum Actions {
        static let GameEnd = "Game End"
        static let move = "move"
    }
    
    let shapeType: ShapeType
    let shapeName: String
    private let shapeColors: SKColor
    private let shapeTrajectory: UIBezierPath
    private(set) var activated = true
    
    // Initializing constructor
    
    init(type: ShapeType) {
        shapeName = type.name()
        shapeTrajectory = type.trajectory()
        shapeType = type
        shapeColors = type.color()
        super.init(texture: nil, color: .clear, size: Shape.defaultSize)
        
        run(.setTexture(AppCache.instance.mainAtlas.textureNamed(type.textureName()), resize: true))

        if BUILD_MODE == .debug {
            let mark = SKSpriteNode(color: .white, size: CGSize(width: 4, height: 4))
            mark.zPosition = 10
            mark.position = .zero
            addChild(mark)
        }
    }

    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
