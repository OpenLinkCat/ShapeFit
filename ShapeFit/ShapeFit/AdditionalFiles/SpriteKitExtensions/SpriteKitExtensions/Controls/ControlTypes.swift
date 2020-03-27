//
//  ControlTypes.swift
//  SpriteKitExtensions
//
//  Created by Ankith on 3/25/20.
//  Copyright © 2020 Ankith. All rights reserved.
//

import SpriteKit

public extension Control {
    
    enum ControlEvent {
        
        case pressDown
        case pressUpInside
        case pressUpOutside
        case pressCancel
        case pressDragExit
        case pressDragOutside
        case pressDragEnter
        case pressDragInside
        case valueChanged 
        case disabledPressDown
    }
    
    internal enum ControlState {
        case normal
        case highlighted
        case selected
        case disabled
        func asString() -> String {
            switch self {
            case .normal:
                return "Normal"
            case .highlighted:
                return "Highlighted"
            case .selected:
                return "Selected"
            case .disabled:
                return "Disabled"
            }
        }
    }
    
    internal enum ControlType {
        case texture
        case shape
        case color
        case label
    }
    
    internal class ShapeNode: SKShapeNode {
        weak var control: Control?
        override func pressesBegan(_ presses: Set<UITouch>, with event: UIEvent?) {
            super.pressesBegan(presses, with: event)
            control?.pressesBegan(presses, with: event)
        }
        override func pressesMoved(_ presses: Set<UITouch>, with event: UIEvent?) {
            super.pressesMoved(presses, with: event)
            control?.pressesMoved(presses, with: event)
        }
        override func pressesEnded(_ presses: Set<UITouch>, with event: UIEvent?) {
            super.pressesEnded(presses, with: event)
            control?.pressesEnded(presses, with: event)
        }
        override func pressesCancelled(_ presses: Set<UITouch>, with event: UIEvent?) {
            super.pressesCancelled(presses, with: event)
            control?.pressesCancelled(presses, with: event)
        }
    }
    
    internal class SpriteNode: SKSpriteNode {
        weak var control: Control?
        override func pressesBegan(_ presses: Set<UITouch>, with event: UIEvent?) {
            super.pressesBegan(presses, with: event)
            control?.pressesBegan(presses, with: event)
        }
        override func pressesMoved(_ presses: Set<UITouch>, with event: UIEvent?) {
            super.pressesMoved(presses, with: event)
            control?.pressesMoved(presses, with: event)
        }
        override func pressesEnded(_ presses: Set<UITouch>, with event: UIEvent?) {
            super.pressesEnded(presses, with: event)
            control?.pressesEnded(presses, with: event)
        }
        override func pressesCancelled(_ presses: Set<UITouch>, with event: UIEvent?) {
            super.pressesCancelled(presses, with: event)
            control?.pressesCancelled(presses, with: event)
        }
    }
}


public extension SKShapeNode {
    convenience init(definition: Definition) {
        self.init()
        self.redefine(definition)
    }
    func redefine(_ definition: Definition) {
        self.path = definition.path
        self.strokeColor = definition.strokeColor
        self.fillColor = definition.fillColor
        self.lineWidth = definition.lineWidth
        self.glowWidth = definition.glowWidth
        self.fillTexture = definition.fillTexture
    }
    
    func definition() -> Definition {
        var shapeDef = Definition(path: self.path!)
        shapeDef.path = self.path!
        shapeDef.strokeColor = self.strokeColor
        shapeDef.fillColor = self.fillColor
        shapeDef.lineWidth = self.lineWidth
        shapeDef.glowWidth = self.glowWidth
        shapeDef.fillTexture = self.fillTexture
        return shapeDef
    }
    
    // MARK: Shape Definition - Description
    
    struct Definition {
        var path: CGPath
        var strokeColor: UIColor = SKColor.white
        var fillColor: UIColor = SKColor.clear
        var lineWidth: CGFloat = 1.0
        var glowWidth: CGFloat = 0.0
        var fillTexture: SKTexture? = nil
        
        public init(path: CGPath) {
            self.path = path
        }
        public init(path: CGPath, color: SKColor) {
            self.path = path
            self.fillColor = color
            self.strokeColor = color
        }
        public init(_ node: SKShapeNode) {
            self = node.definition()
        }
        public init?(_ node: SKShapeNode?) {
            if let shape = node { self.init(shape) }
            else { return nil }
        }
    }
}
