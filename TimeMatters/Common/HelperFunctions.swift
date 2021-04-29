//
//  HelperFunctions.swift
//  TimeMatters
//
//  Created by Chhoden Sherpa on 4/26/21.
//

import UIKit

struct HelperFunctions {

    static func setDarkMode(nightMode: Bool) {
        UserDefaults.standard.set(nightMode, forKey: "darkMode")
        setDarkUI()
    }
    
    static func getDarkMode() -> Bool{
        return UserDefaults.standard.bool(forKey: "darkMode")
    }
    
    static func setDarkUI() {
        UIApplication.shared.windows.forEach { window in
            window.overrideUserInterfaceStyle = getDarkMode() ? .dark : .light
        }
    }
}
