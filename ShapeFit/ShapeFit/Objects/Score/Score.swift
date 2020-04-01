//
//  Score.swift
//  ShapeFit
//
//  Created by Ankith on 3/27/20.
//  Copyright © 2020 Ankith. All rights reserved.
//

import Foundation

struct Score {
    var points = 0
    
    init(points: Int) {
        self.points = points
    }
    
    func highScorePoints() -> Int {
        return AppPersistence.highScorePoints
    }
}
