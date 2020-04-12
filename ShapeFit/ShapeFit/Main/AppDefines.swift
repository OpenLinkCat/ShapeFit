//
//  AppDefines.swift
//  ShapeFit
//
//  Created by Ankith on 3/27/20.
//  Copyright © 2020 Ankith. All rights reserved.
//

import Foundation
import SpriteKit

enum AppDefines {
    
    //TODO: Add Constants
    
    enum Constants {
        static let mainLeaderboardID = "grp.Shapezoid"
        static let appStoreID = "id1507022672"
        static let appStoreLink = "https://itunes.apple.com/us/app/id1507022672"
        static let isiPad = UIDevice.current.userInterfaceIdiom == .pad
        static let isiPhoneX: Bool = UIDevice().userInterfaceIdiom == .phone && UIScreen.main.nativeBounds.height == 2436
    }
    
    enum FontName {
        static let defaultLight = "VAGRoundedStd-Light"
        static let defaultBlack = "VAGRoundedStd-Black"
        static let defaultBold = "VAGRoundedStd-Bold"
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
