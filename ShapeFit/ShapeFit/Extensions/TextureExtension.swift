//
//  TextureExtension.swift
//  ShapeFit
//
//  Created by Ankith on 3/24/20.
//  Copyright © 2020 Ankith. All rights reserved.
//

import SpriteKit

extension SKTexture {
    convenience init(radialGradient size: CGSize, colors: [SKColor]) {
        self.init(image: UIImage.radialGradient(size: size, colors: colors))
    }
    convenience init(linearGradient size: CGSize, colors: [SKColor]) {
        self.init(image: UIImage.linearGradient(size: size, colors: colors))
    }
    convenience init(circleOfRadius radius: CGFloat, color: SKColor) {
        self.init(image: UIImage.circle(withRadius: radius, color: color))
    }
    convenience init(squareOfLength length: CGFloat, color: UIColor) {
        self.init(image: UIImage.square(withLength: length, color: color))
    }
    convenience init(pentagonWithWidth width: CGFloat, color: UIColor) {
        self.init(image: UIImage.pentagon(withWidth: width, color: color))
    }
    convenience init(triangleWithSize size: CGSize, color: UIColor) {
        self.init(image: UIImage.triangle(withSize: size, color: color))
    }
}
