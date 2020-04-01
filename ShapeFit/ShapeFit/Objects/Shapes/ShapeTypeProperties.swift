//
//  ShapeProperties.swift
//  ShapeFit
//
//  Created by Ankith on 3/22/20.
//  Copyright © 2020 Ankith. All rights reserved.
//

import SpriteKit

extension ShapeType {
    func name() -> String {
        switch self {
        case .circle:
            return "Circle"
        case .square:
            return "Square"
        case .triangle:
            return "Triangle"
        case .pentagon:
            return "Pentagon"
        }
    }
    
    func textureName() -> String {
        switch self {
        case .circle:
            return "shape_circle"
        case .square:
            return "shape_square"
        case .triangle:
            return "shape_triangle"
        case .pentagon:
            return "shape_pentagon"
        }
    }
    
    func trajectory() -> UIBezierPath {
        switch self {
        case .circle:
            return Circle.trajectory()
        case .square:
            return Square.trajectory()
        case .triangle:
            return Triangle.trajectory()
        case .pentagon:
            return Pentagon.trajectory()
        }
    }
    
    func spinnerTrajectory(size: CGSize) -> UIBezierPath {
        switch self {
        case .circle:
            return Circle.spinnerTrajectory(size: size)
        case .square:
            return Square.spinnerTrajectory(size: size)
        case .triangle:
            return Triangle.spinnerTrajectory(size: size)
        case .pentagon:
            return Pentagon.spinnerTrajectory(size: size)
        }
    }
    
    func drawBorder(onPath path: UIBezierPath, size: CGSize) {
        switch self {
        case .circle:
            Circle.drawBorder(onTrajectory: path, size: size)
        case .square:
            Square.drawBorder(onTrajectory: path, size: size)
        case .triangle:
            Triangle.drawBorder(onTrajectory: path, size: size)
        case .pentagon:
            Pentagon.drawBorder(onTrajectory: path, size: size)
        }
    }
    
    func color() -> SKColor {
        switch self {
        case .pentagon:
            return .red
        case .square:
            return .orange
        case .triangle:
            return .purple
        case .circle:
            return .green
        }
    }
}
