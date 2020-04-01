//
//  ShapeProperties.swift
//  ShapeFit
//
//  Created by Ankith on 3/22/20.
//  Copyright © 2020 Ankith. All rights reserved.
//

import SpriteKit

extension ShapeType {
    
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
    
    func textureName() -> String {
        switch self {
        case .circle:
            return "shape_circle"
        case .triangle:
            return "shape_triangle"
        case .square:
            return "shape_square"
        case .pentagon:
            return "shape_pentagon"
        }
    }
    
    func trajectory() -> UIBezierPath {
        switch self{
        case .circle:
            return Circle.trajectory()
        case .triangle:
            return Triangle.trajectory()
        case .square:
            return Square.trajectory()
        case .pentagon:
            return Pentagon.trajectory()
        }
    }
    
    func spinnerPath(size: CGSize) -> UIBezierPath {
        switch self {
        case .circle:
            return Circle.spinnerTrajectory(size: size)
        case .triangle:
            return Triangle.spinnerTrajectory(size: size)
        case .square:
            return Square.spinnerTrajectory(size: size)
        case .pentagon:
            return Pentagon.spinnerTrajectory(size: size)
        }
    }
    
    func createBorder(onPath path: UIBezierPath, size: CGSize) {
        switch self {
        case .circle:
            Circle.createBorder(onTrajectory: path, size: size)
        case .triangle:
            Triangle.createBorder(onTrajectory: path, size: size)
        case .square:
            Square.createBorder(onTrajectory: path, size: size)
        case .pentagon:
            Pentagon.createBorder(onTrajectory: path, size: size)
        }
    }
    
    // Keep func color() at the bottom since it stops the rest of the code from executing
    
    func color() -> SKColor {
        switch self {
        case .pentagon:
            return .blue
        case .triangle:
            return .green
        case .square:
            return .red
        case .circle:
            return .yellow
        }
        
    }
}
