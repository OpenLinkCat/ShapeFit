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
    static let defaultSize = CGSize(width: 50, height: 50)
    var timeToDisappear: TimeInterval = 0
    var disappearingTime: TimeInterval = 0.2
    var moveTime: TimeInterval = 0.8
    var failureNoticeTime: TimeInterval = 0.8
    var shapeCreationTime: TimeInterval = 0.4
    
    enum Actions {
        static let GameEnd = "Game End"
        static let move = "move"
    }
    let shapeType: ShapeType
    let shapeName: String
    private let shapeColor: SKColor
    private let shapeTrajectory: UIBezierPath
    private(set) var activated = true
    
    // Initializing constructor
    
    init(type: ShapeType) {
        shapeName = type.name()
        shapeTrajectory = type.trajectory()
        shapeType = type
        shapeColor = type.color()
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
    
    func activatePhysicsBody() {
        let path = shapeType.trajectory()
        let physicsBody = SKPhysicsBody(polygonFrom: path.cgPath)
        let shapeCategory = PhysicsCategory.category(of: shapeType)
        physicsBody.categoryBitMask = shapeCategory.rawValue
        physicsBody.collisionBitMask = PhysicsCategory.collision(with: shapeCategory)
        physicsBody.contactTestBitMask = PhysicsCategory.contact(with: shapeCategory)
        physicsBody.allowsRotation = true
        physicsBody.usesPreciseCollisionDetection = true
        physicsBody.friction = 10
        physicsBody.mass = 0
        physicsBody.restitution = 0
        physicsBody.linearDamping = 0
        physicsBody.angularDamping = 0
        self.physicsBody = physicsBody
    }
    
    func countToExplode() {
        run(.sequence([.wait(forDuration: 1), .run({ () -> Void in
            self.failure()
        })]), withKey: Actions.GameEnd)
    }
    
    func releaseMe() {
        let effect = SKTMoveEffect(node: self, duration: moveTime, startPosition: position, endPosition: CGPoint(x: 0, y: -scene!.size.height/2))
        effect.timingFunction = SKTTimingFunctionLinear
        run(.actionWithEffect(effect), withKey: Actions.move)
    }
    
    func create(_ completion: (() -> Void)? = nil) {
        let appear: SKAction = .appearAnimated(self, time: CGFloat(shapeCreationTime), scale: 1)

        if let completion = completion { run(appear, completion: completion) }
        else { run(appear) }

        if let sound = AppCache.instance.creationSound {
            run(.afterDelay(shapeCreationTime, performAction: sound))
        }
    }
    
    func success(_ special: Bool, completion: (() -> Void)? = nil) {
        activated = false
        removeAllActions()
        
        if let sound = special ? AppCache.instance.successSoundSpecial : AppCache.instance.successSound {
            run(sound)
        }
        physicsBody = nil

        let disappear: SKAction = .disappearAnimated(self, time: CGFloat(disappearingTime))
        let sequence: SKAction = .sequence([disappear, .removeFromParent()])
        if timeToDisappear > 0 {
            run(.afterDelay(timeToDisappear, performAction: sequence))
        } else {
            run(sequence)
        }
    }
    
    func failure(_ completion: (() -> Void)? = nil) {
        activated = false
        removeAllActions()
        if let failure = AppCache.instance.failureSound { run(failure) }
        physicsBody = nil
        
        let disappear: SKAction = .disappearAnimated(self, time: CGFloat(failureNoticeTime/2))
        
        let sequence: SKAction = .sequence([.group([disappear, .wait(forDuration: failureNoticeTime*2)]), .removeFromParent()])

        if let completion = completion {
            run(sequence, completion: completion)
        } else {
            run(sequence)
        }
    }
    
    
    func animationAction(_ textures: [SKTexture], duration: TimeInterval, completion: (() -> Void)? = nil) -> SKAction {
        let group: SKAction = .animate(with: textures, timePerFrame: duration/TimeInterval(textures.count), resize: true, restore: false)
        var sequence = [group]
        if let completion = completion {
            sequence.append(.afterDelay(duration, runBlock: completion))
        }
        return .group(sequence)
    }
}
