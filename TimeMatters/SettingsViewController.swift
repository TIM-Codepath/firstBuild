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
    
    private var darkMode: Bool = false {
        didSet {
            overrideUserInterfaceStyle = self.darkMode ? .dark : .light
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        darkMode = HelperFunctions.getDarkMode()
        
        darkModeSwitch.isOn = darkMode
        
        darkModeSwitch.addTarget(self, action: #selector(SettingsViewController.onSwitchButton(_:)), for: .valueChanged)
        
       
        darkModeSwitch.onTintColor = .systemBlue
    }
    

        // Do any additional setup after loading the view.
    
    
    @objc func onSwitchButton(_ nightSwitch: UISwitch) {
        self.darkMode = nightSwitch.isOn
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


