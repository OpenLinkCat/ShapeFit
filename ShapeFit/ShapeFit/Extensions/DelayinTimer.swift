//
//  DelayinTimer.swift
//  ShapeFit
//
//  Created by Ankith on 3/25/20.
//  Copyright © 2020 Ankith. All rights reserved.
//

import Foundation

public func delay(_ delay: Double, closure: @escaping (() -> Void)) {
    DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: closure)
}
