//
//  ControlHelpers.swift
//  SpriteKitExtensions
//
//  Created by Ankith on 3/25/20.
//  Copyright © 2020 Ankith. All rights reserved.
//

import SpriteKit

internal extension Control {
    
    func playSound(instanceSoundFileName fileName: String?, defaultSoundFileName: String?) {
        
        let soundEnabled = Control.defaultSoundEffectsEnabled ?? soundEffectsEnabled
        
        if soundEnabled {
            if let soundFileName = fileName {
                let action = SKAction.playSoundFileNamed(soundFileName, waitForCompletion: true)
                
                // When run, the sound effect `SKAction` only one time
                // SpriteKit simply fails to load the .wav in memory on some devices
                
                self.run(action)
                self.run(action)
            }
            else if let soundFileName = defaultSoundFileName {
                let action = SKAction.playSoundFileNamed(soundFileName, waitForCompletion: true)
                
                // When run, the sound effect `SKAction` only one time
                // SpriteKit simply fails to load the .wav in memory on some devices
                
                self.run(action)
                self.run(action)
            }
        }
    }
}

