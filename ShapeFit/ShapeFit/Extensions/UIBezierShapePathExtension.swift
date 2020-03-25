//
//  UIBezierShapePaths.swift
//  ShapeFit
//
//  Created by Ankith on 3/24/20.
//  Copyright © 2020 Ankith. All rights reserved.
//

import UIKit

extension UIBezierPath {
    convenience init(triangleIn size: CGSize) {
        self.init()
        let height = size.height
        let halfHeight = height/2
        let width = size.width
        let halfWitdth = width/2
        move(to: CGPoint(x: -halfWitdth, y: halfHeight))
        addLine(to: CGPoint(x: halfWitdth, y: halfHeight))
        addLine(to: CGPoint(x: 0, y: -halfHeight))
        close()
        
    }
    
    convenience init(pentagonWith width: CGFloat) {
        self.init()
        let sidesCount: Int = 5
        let numberOfSides = CGFloat(sidesCount)
        
        let length = width * sqrt((numberOfSides - sqrt(numberOfSides)) / 10)
        
        for i in 0..<sidesCount {
            let angle: CGFloat = CGFloat(i) * ((2 * .pi) / numberOfSides) - (.pi / 2)
            let point = CGPoint(x: length * cos(angle), y: -length * sin(angle) + 2 * ((width / 2) - length))
            
            if i == 0 { move(to: point) }
            else { addLine(to: point) }
        }
        close()
    }
}
