//
//  ShapeTypeExtensionFunction.swift
//  ShapeFit
//
//  Created by Ankith on 3/22/20.
//  Copyright © 2020 Ankith. All rights reserved.
//

import SpriteKit

extension ShapeTypeTrajectories {
    enum Circle {
        private static let radius: CGFloat = 40
        private static let percentage: CGFloat = 0.4
        
        static func trajectory() -> UIBezierPath {
            let originOfMovement = CGPoint(x: -radius, y: -radius)
            let size = CGSize(width: 2 * radius, height: 2 * radius)
            return UIBezierPath(ovalIn: CGRect(origin:originOfMovement, size: size))
        }
    }
    static func spinnerTrajectory(size: CGSize) -> UIBezierPath {
        let newRadius = radius * 1.05
        let trajectory = UIBezierPath()
        trajectory.move(to: CGPoint(x: newRadius, y: size.height / 2))
        trajectory.addLine(to: CGPoint(x: size.width / 2, y: size.height / 2))
        trajectory.addLine(to: CGPoint(x: 0, y: -size.height / 2))
        trajectory.addLine(to: CGPoint(x: -size.width / 2, y: size.height / 2))
        trajectory.addLine(to: CGPoint(x: -newRadius, y: size.height / 2))
    }

    // Tweak numbers
    
    static func border(onTrajectory trajectory: UIBezierPath, size: CGSize) {
        let newRadius = radius * 1.05
        let inside = 2 * newRadius * 0.5
        let angle = 2 * acos(1-inside/newRadius)
        
        
    }
}
