//
//  AppPersistance.swift
//  ShapeFit
//
//  Created by Ankith on 3/27/20.
//  Copyright © 2020 Ankith. All rights reserved.
//

import Foundation
import SpriteKit

// TODO: Add appStoreID and appStoreLink

enum AppDefines {
    enum Constants {
        static let mainLeaderboardID = "ShapeFitLeaderboard"
        static let appStoreID = ""
        static let appStoreLink = ""
        static let isiPad = UIDevice.current.userInterfaceIdiom == .pad
        static let isiPhoneX: Bool = UIDevice().userInterfaceIdiom == .phone && UIScreen.main.nativeBounds.height == 2436
    }
    
    enum FontName {
        static let defaultLight = "VAGRoundedSTD-Light"
        static let defaultBlack = "VAGRoundedSTD-Black"
        static let defaultBold = "VAGRoundedSTD-Bold"
    }
    
    enum Timings {
        static let fadeIn: TimeInterval = 0.6
        static let fadeOut: TimeInterval = 0.4
        static let slide: TimeInterval = 0.6
        static let transitionDelay: TimeInterval = 0.4
    }
    
    enum Transition {
        static let toGame = SKTransition.doorsOpenVertical(withDuration: Timings.transitionDelay)
        static let toInitial = SKTransition.doorsCloseVertical(withDuration: Timings.transitionDelay)
    }
}
