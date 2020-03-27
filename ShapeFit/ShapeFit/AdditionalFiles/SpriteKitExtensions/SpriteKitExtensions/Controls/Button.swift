//
//  Button.swift
//  SpriteKitExtensions
//
//  Created by Ankith on 3/25/20.
//  Copyright © 2020 Ankith. All rights reserved.
//

// MARK: Remember To not include SpriteKitExtensions in Compile Sources for main project
import SpriteKit

open class Button: Control {
    
    public convenience init(normalText: String, highlightedText: String?) {
        self.init(normalText: normalText, selectedText: nil, singleHighlightedText: highlightedText, disabledText: nil)
    }
    
    public convenience init(normalTexture: SKTexture, highlightedTexture: SKTexture?) {
        self.init(normalTexture: normalTexture, selectedTexture: nil, singleHighlightedTexture: highlightedTexture, disabledTexture: nil)
    }
    
    public convenience init(normalShape: SKShapeNode.Definition, highlightedShape: SKShapeNode.Definition?) {
        self.init(normalShape: normalShape, selectedShape: nil, singleHighlightedShape: highlightedShape, disabledShape: nil)
    }
    
    public convenience init(size: CGSize, normalColor: SKColor, highlightedColor: SKColor?) {
        self.init(size: size, normalColor: normalColor, selectedColor: nil, singleHighlightedColor: highlightedColor, disabledColor: nil)
    }

    
    internal override func touchDown() {
        self.highlighted = true
        super.touchDown()
    }
    
    internal override func disabledTouchDown() {
        super.disabledTouchDown()
    }
    
    internal override func drag() {
        super.drag()
    }
    
    internal override func dragExit() {
        self.highlighted = false
        super.dragExit()
    }
    
    internal override func dragOutside() {
        super.dragOutside()
    }
    
    internal override func dragEnter() {
        self.highlighted = true
        super.dragEnter()
    }
    
    internal override func dragInside() {
        super.dragInside()
    }
    
    open override func touchUpInside() {
        self.highlighted = false
        super.touchUpInside()
    }
    
    internal override func touchUpOutside() {
        super.touchUpOutside()
    }
}
