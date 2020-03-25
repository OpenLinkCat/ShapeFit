//
//  Doubles+Floats.swift
//  ShapeFit
//
//  Created by Ankith on 3/25/20.
//  Copyright © 2020 Ankith. All rights reserved.
//

import UIKit
import Foundation

extension Double {
    func relative(min: Double, max: Double) -> Double {
        return min + self * (max - min)
    }
}

extension CGPoint {
    func isClose(to point: CGPoint, with range: CGFloat) -> Bool {
        let xMax = point.x + range
        let xMin = point.x - range
        let yMax = point.y + range
        let yMin = point.y - range
        
        if (x >= xMin && x <= xMax) && (y >= yMin && y <= yMax) {
            return true
        } else {
            return false
        }
    }
}
