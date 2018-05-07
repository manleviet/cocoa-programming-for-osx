//
//  PreferenceManager.swift
//  SpeakLine
//
//  Created by Lê Viết Mẫn on 8/14/15.
//  Copyright (c) 2015 Lê Viết Mẫn. All rights reserved.
//

import Cocoa

private let activeVoiceKey = "activeVoice"
private let activeTextKey = "activeText"

class PreferenceManager {
    private let userDefaults = NSUserDefaults.standardUserDefaults()
    
    var activeVoice: String? {
        get {
            return userDefaults.objectForKey(activeVoiceKey) as? String
        }
        set (newActiveVoice) {
            userDefaults.setObject(newActiveVoice, forKey: activeVoiceKey)
        }
    }
    
    var activeText: String? {
        get {
            return userDefaults.objectForKey(activeTextKey) as? String
        }
        set (newActiveText) {
            userDefaults.setObject(newActiveText, forKey: activeTextKey)
        }
    }
    
    init() {
        registerDefaultPreferences()
    }
    
    func registerDefaultPreferences() {
        let defaults = [activeVoiceKey: NSSpeechSynthesizer.defaultVoice(),
            activeTextKey: "Able was I ere I saw Elba."]
        
        userDefaults.registerDefaults(defaults)
    }
}