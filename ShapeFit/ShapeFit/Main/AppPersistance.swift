//
//  AppPersistance.swift
//  ShapeFit
//
//  Created by Ankith on 3/27/20.
//  Copyright © 2020 Ankith. All rights reserved.
//

import SpriteKit

enum AppPersistence {
    static func newPlayedMatch() {
        matchesPlayedSinceLaunch += 1
        print("STATISTICS: \(matchesPlayedSinceLaunch) matches since launch")
        print("STATISTICS: \(matchesPlayedSinceTheBeginningOfTime) total matches")
    }
    
    static func saveNewScore(_ score: Score) {
        if score.points > highScorePoints {
            highScorePoints = score.points
            reportNewAchievement(points: score.points)
        }
        
        GCHelper.sharedInstance.reportLeaderboardIdentifier(AppDefines.Constants.mainLeaderboardID, score: score.points)
    }
    
    static func resetUserDefaults() {
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
    }
    
    static var matchesPlayedSinceLaunch: Int = 0 {
        didSet {
            if matchesPlayedSinceLaunch != 0 {
                matchesPlayedSinceTheBeginningOfTime += 1
            }
        }
    }
    
    static var matchesPlayedSinceTheBeginningOfTime: Int {
        set {
            UserDefaults.standard.setValue(newValue, forKey: #function)
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.integer(forKey: #function)
        }
    }
    
    static var alreadyPlayTutorial: Bool {
        set {
            UserDefaults.standard.setValue(newValue, forKey: #function)
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.bool(forKey: #function)
        }
    }
    

    static var highScorePoints: Int {
        set {
            UserDefaults.standard.setValue(newValue, forKey: #function)
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.integer(forKey: #function)
        }
    }
    
    private static func reportNewAchievement(points: Int) {
        GCHelper.sharedInstance.reportAchievementIdentifier("grp.10Points", percent: 100 * Double(points) / 10)
        GCHelper.sharedInstance.reportAchievementIdentifier("grp.20Points", percent: 100 * Double(points) / 20)
        GCHelper.sharedInstance.reportAchievementIdentifier("grp.30Points", percent: 100 * Double(points) / 30)
        GCHelper.sharedInstance.reportAchievementIdentifier("grp.40Points", percent: 100 * Double(points) / 40)
        GCHelper.sharedInstance.reportAchievementIdentifier("grp.Shapezoid_50Points", percent: 100 * Double(points) / 50)
        GCHelper.sharedInstance.reportAchievementIdentifier("grp.60Points", percent: 100 * Double(points) / 60)
        GCHelper.sharedInstance.reportAchievementIdentifier("grp.70Points", percent: 100 * Double(points) / 70)
        GCHelper.sharedInstance.reportAchievementIdentifier("grp.80Points", percent: 100 * Double(points) / 80)
        GCHelper.sharedInstance.reportAchievementIdentifier("grp.90Points", percent: 100 * Double(points) / 90)
        GCHelper.sharedInstance.reportAchievementIdentifier("grp.Shapezoid_100Points", percent: 100 * Double(points) / 100)
    }
}
