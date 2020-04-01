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
    case square
    case triangle
    case pentagon
    
    static let allCases: [ShapeType] = [.circle, .square, .triangle, .pentagon]
    
    static var lastRandomShapeIndex: Int = 0
    static func randomShape() -> Shape {
        var i = 0
        repeat {
            i = Int.random(allCases.count)
        } while i == lastRandomShapeIndex
        
        lastRandomShapeIndex = i
        return Shape(type: allCases[i])
    }
}
