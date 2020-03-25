//
//  ShapeTypeExtensionFunction.swift
//  ShapeFit
//
//  Created by Ankith on 3/22/20.
//  Copyright © 2020 Ankith. All rights reserved.
//

import SpriteKit

// TODO: Tweak all the numbers

extension ShapeType {
    
    enum Circle {
        private static let radius: CGFloat = 40
        private static let percentage: CGFloat = 0.4
        
        // Creates the the trajectory/path of the Circle
        static func trajectory() -> UIBezierPath {
            let originOfMovement = CGPoint(x: -radius, y: -radius)
            let size = CGSize(width: 2 * radius, height: 2 * radius)
            return UIBezierPath(ovalIn: CGRect(origin:originOfMovement, size: size))
        }
        
        // The trajectory/path for the spinner
        static func spinnerTrajectory(size: CGSize) -> UIBezierPath {
            let newRadius = radius * 1.05
            let trajectory = UIBezierPath()
            let inside = 2 * newRadius * percentage
            let angle = 2 * acos(1-inside / newRadius)
            trajectory.move(to: CGPoint(x: newRadius, y: size.height / 2))
            trajectory.addLine(to: CGPoint(x: size.width / 2, y: size.height / 2))
            trajectory.addLine(to: CGPoint(x: 0, y: -size.height / 2))
            trajectory.addLine(to: CGPoint(x: -size.width / 2, y: size.height / 2))
            trajectory.addLine(to: CGPoint(x: -newRadius, y: size.height / 2))
            trajectory.addArc(withCenter: CGPoint(x: 0, y: (size.height / 2) + newRadius - inside),
                radius: newRadius,
                startAngle: .pi + .pi/2 - angle/2,
                endAngle: .pi + .pi/2 + angle/2,
                clockwise: true
            )
            trajectory.close()
            return trajectory
        }
        
        // Creating a Border for the circle
        static func createBorder(onTrajectory trajectory: UIBezierPath, size: CGSize) {
            let newRadius = radius * 1.05
            let inside = 2 * newRadius * 0.5
            let angle = 2 * acos(1-inside/newRadius)
            
            trajectory.addLine(to: CGPoint(x: -size.width / 2, y: size.height / 2))
            trajectory.addArc(withCenter: CGPoint(x: 0, y: size.height / 2 + newRadius - inside),
                         radius: newRadius,
                         startAngle: .pi + .pi/2 - angle / 2,
                         endAngle: .pi + .pi/2 + angle / 2,
                         clockwise: true)
            trajectory.addLine(to: CGPoint(x: size.width / 2, y: size.height / 2))
        }
    }
    
    enum Triangle {
        private static let base: CGFloat = 80
        private static let height: CGFloat = 70
        private static let percentage: CGFloat = 0.66
        
        static func trajectory() -> UIBezierPath {
            let size = CGSize(width: base, height: height)
            return UIBezierPath(triangleIn: size)
        }
        
        static func spinnerTrajectory(size: CGSize) -> UIBezierPath {
            let v1 = CGVector(dx: base, dy: height / 2)
            let v2 = CGVector(angle: v1.angle)
            let cons = height * percentage / v2.dx
            let v3 = v2 * cons
            let open = 2 * v3.dy * 1.3
            let trajectory = UIBezierPath()
            
            trajectory.move(to: CGPoint(x: open / 2, y: size.height / 2))
            trajectory.addLine(to: CGPoint(x: size.width / 2, y: size.height / 2))
            trajectory.addLine(to: CGPoint(x: 0, y: -size.height / 2))
            trajectory.addLine(to: CGPoint(x: -size.width / 2, y: size.height / 2))
            trajectory.addLine(to: CGPoint(x: -open / 2, y: size.height / 2))
            
            trajectory.addLine(to: CGPoint(x: 0, y: size.height / 2 - height * percentage))
            trajectory.addLine(to: CGPoint(x: open / 2, y: size.height / 2))
            
            trajectory.close()
            return trajectory
        }
        
        static func createBorder(onTrajectory trajectory: UIBezierPath, size: CGSize) {
            let vector1 = CGVector(dx: base, dy: height / 2)
            let vector2 = CGVector(angle: vector1.angle)
            let const = height * percentage / vector2.dx
            let vector3 = vector2 * const
            let open = 2 * vector3.dy * 1.3
            
            trajectory.addLine(to: CGPoint(x: -size.width / 2, y: size.height / 2))
            trajectory.addLine(to: CGPoint(x: -open / 2, y: size.height / 2))
            
            trajectory.addLine(to: CGPoint(x: 0, y: size.height / 2 - height * percentage))
            trajectory.addLine(to: CGPoint(x: open / 2, y: size.height / 2))
        }
        
    }
    
    enum Square {
        
    }
    
    enum Pentagon {
        
    }
}
