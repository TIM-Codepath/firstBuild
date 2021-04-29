//
//  SettingsViewController.swift
//  TimeMatters
//
//  Created by Chhoden Sherpa on 4/26/21.
//

import UIKit
import Parse

class SettingsViewController: UIViewController {

    
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


