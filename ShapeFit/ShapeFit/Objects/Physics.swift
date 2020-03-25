//
//  Physics.swift
//  ShapeFit
//
//  Created by Ankith on 3/24/20.
//  Copyright © 2020 Ankith. All rights reserved.
//

import Foundation

enum PhysicsCategory: UInt32 {
    case none       = 0
    case all        = 0xFFFFFFFF
    case scene      = 0b1
    case spinner    = 0b10
    case triangle   = 0b100
    case square     = 0b1000
    case circle     = 0b10000
    case pentagon   = 0b100000
    
    static var allShapes: PhysicsCategory.RawValue {
        return triangle.rawValue | square.rawValue | circle.rawValue | pentagon.rawValue
    }
    
    static func category(of shapeType: ShapeType) -> PhysicsCategory {
        switch shapeType {
        case .triangle:
            return .triangle
        case .square:
            return .square
        case .circle:
            return .circle
        case .pentagon:
            return .pentagon
        }
    }
    
    static func contact(with category: PhysicsCategory) -> PhysicsCategory.RawValue {
        switch category {
        case .triangle, .square, .circle, .pentagon:
            return allShapes
        case .none:
            return none.rawValue
        default:
            assertionFailure("Doesn't have a category match (contact)")
            return none.rawValue
        }
    }
    
    static func collision(with category: PhysicsCategory) -> PhysicsCategory.RawValue {
        switch category {
        case .triangle, .square, .circle, .pentagon:
            return allShapes
        case .none:
            return none.rawValue
        default:
            assertionFailure("Doesn't have a category match (collision)")
            return none.rawValue
        }
    }
}
