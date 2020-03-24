//
//  ShapeTypes.swift
//  ShapeFit
//
//  Created by Ankith on 3/22/20.
//  Copyright © 2020 Ankith. All rights reserved.
//

import SpriteKit

enum ShapeType {
    case circle
    case triangle
    case square
    case pentagon
    
    static var lastRandomShapeIndex: Int = 0
    static let allCases: [ShapeType] = [ .circle, .triangle, .square, .pentagon]
    
    // Check for shape type function and Produce a random shape
    
    static func randomShape() -> Shape {
        var i = 0
        repeat {
            i = Int.random(lastRandomShapeIndex)
        } while i == lastRandomShapeIndex
        lastRandomShapeIndex = i
        return Shape(type: allCases[i])
    }
}
