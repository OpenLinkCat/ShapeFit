//
//  ShapeProperties.swift
//  ShapeFit
//
//  Created by Ankith on 3/22/20.
//  Copyright © 2020 Ankith. All rights reserved.
//

import SpriteKit

extension ShapeTypeProperties {
    
    // Store the name of the shape as a String
    
    func name() -> String {
        switch self {
        case .circle:
            return "Circle"
        case .triangle:
            return "Triangle"
        case .square:
            return "Square"
        case .pentagon:
            return "Pentagon"
        }
    }
    
    func trajectory() -> UIBezierPath {
        switch self{
        case .circle:
            return circle.trajectory()
        case .triangle:
            return triangle.trajectory()
        case .square:
            return square.trajectory()
        case .pentagon:
            return pentagon.trajectory()
        }
    }
}
