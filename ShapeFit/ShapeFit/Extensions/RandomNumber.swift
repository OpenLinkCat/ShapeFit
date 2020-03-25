//
//  RandomNumber.swift
//  ShapeFit
//
//  Created by Ankith on 3/24/20.
//  Copyright © 2020 Ankith. All rights reserved.
//

import UIKit

extension Int {
    
    // Returns a random number in the range specified
    
    public static func random(within range: Range<Int>) -> Int {
        return Int(arc4random_uniform(UInt32(range.upperBound - range.lowerBound))) + range.lowerBound
    }
}
