//
//  TextureExtension.swift
//  ShapeFit
//
//  Created by Ankith on 3/24/20.
//  Copyright © 2020 Ankith. All rights reserved.
//

import SpriteKit

/* TODO: Add UIImage Extension functions for:
 - circle
 - triangle
 - square
 - pentagon
 - radialGradient
 - linearGradient
 */

extension SKTexture {
    convenience init(circleOfRadius radius: CGFloat, color: SKColor) {
        self.init(image: UIImage.circle(withRadius: radius, color: color))
    }
    convenience init(triangleWithSize size: CGSize, color: UIColor) {
        self.init(image: UIImage.triangle(withSize: size, color: color))
    }
    convenience init(squareOfLength lenght: CGFloat, color: UIColor) {
        self.init(image: UIImage.square(withLenght: lenght, color: color))
    }
    convenience init(pentagonWithWidth width: CGFloat, color: UIColor) {
        self.init(image: UIImage.pentagon(withWidth: width, color: color))
    }
    convenience init(radialGradient size: CGSize, colors: [SKColor]) {
        self.init(image: UIImage.radialGradient(size: size, colors: colors))
    }
    convenience init(linearGradient size: CGSize, colors: [SKColor]) {
        self.init(image: UIImage.linearGradient(size: size, colors: colors))
    }
    
}
