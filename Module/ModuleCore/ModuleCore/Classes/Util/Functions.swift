//
//  Functions.swift
//  ModuleCore_Example
//
//  Created by xabdaz on 07/04/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation
public class Functions  {
    public class func setToPlist<T>(_ key: String, object: T?, suiteName: String? = nil) {
        guard object != nil else {
            removeFromPlist(key, suiteName: suiteName)
            return
        }
        if let groupName = suiteName,
            let userDefaults = UserDefaults.init(suiteName: groupName) {
            userDefaults.set(object, forKey: key)
            userDefaults.synchronize()
        } else {
            let defaults = UserDefaults.standard
            defaults.set(object, forKey: key)
            defaults.synchronize()
        }
    }
    public class func getFromPlist<T>(_ key: String, suiteName: String? = nil) -> T? {
        if let groupName = suiteName,
            let userDefaults = UserDefaults.init(suiteName: groupName) {
            return userDefaults.object(forKey: key) as? T
        } else {
            let defaults = UserDefaults.standard
            return defaults.object(forKey: key) as? T
        }
    }
    public class func removeFromPlist(_ key: String, suiteName: String? = nil) {
        if let groupName = suiteName,
            let userDefaults = UserDefaults.init(suiteName: groupName) {
            userDefaults.removeObject(forKey: key)
            userDefaults.synchronize()
        } else {
            let defaults = UserDefaults.standard
            defaults.removeObject(forKey: key)
            defaults.synchronize()
        }
    }
}
