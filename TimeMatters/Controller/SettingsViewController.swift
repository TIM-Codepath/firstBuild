//
//  SettingsViewController.swift
//  TimeMatters
//
//  Created by Chhoden Sherpa on 4/26/21.
//

import UIKit
import Parse

class SettingsViewController: UIViewController {
    
    let user = PFUser.current()!
    lazy var timeLogs = (user["logs"] != nil) ? user["logs"] as! [String : [Int]] : [:]
    lazy var presets = (user["presets"] != nil) ? user["presets"] as! Array<String> : []

    
    @IBOutlet weak var darkModeSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        darkModeSwitch.isOn = HelperFunctions.getDarkMode()
        
        darkModeSwitch.addTarget(self, action: #selector(SettingsViewController.onSwitchButton(_:)), for: .valueChanged)
        
       
        darkModeSwitch.onTintColor = .systemBlue
    }
    
    @objc func onSwitchButton(_ nightSwitch: UISwitch) {
        HelperFunctions.setDarkMode(nightMode: nightSwitch.isOn)
    }
    
    
    @IBAction func onLogoutButton(_ sender: Any) {
        
        //temporarily placing code block that resets values in database. For now, to reset the value in the data base, just log out and log back in.
        for presetIndex in 0...timeLogs.count-1
        {
            let presetID:String = presets[presetIndex]
            timeLogs[presetID]?.removeAll()
            timeLogs[presetID]?.append(0)
            user["logs"] = timeLogs
            user.saveInBackground()
            print("deleted all data")
        }
        //...end of temp code block
        
        PFUser.logOut()

        let main = UIStoryboard(name: "Main", bundle: nil)

        let loginViewContoller = main.instantiateViewController(withIdentifier: "LoginViewController")

        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
        let delegate = windowScene.delegate as? SceneDelegate else {
            return
        }
        delegate.window?.rootViewController = loginViewContoller
    }
}
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


