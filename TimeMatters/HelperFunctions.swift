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
    }
    
    static func getDarkMode() -> Bool{
        return UserDefaults.standard.bool(forKey: "darkMode")
    }
    
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


