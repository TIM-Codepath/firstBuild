//
//  LoginViewController.swift
//  TimeMatters
//
//  Created by Aryum Jeon on 4/10/21.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
//    let user = PFUser.current()!
//    let now = Calendar.current.dateComponents(in: .current, from: Date())
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        
        let signUpViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "signUpViewController") as SignUpViewController
        self.present(signUpViewController, animated: true, completion: nil)
    }
    
    @IBAction func onSignIn(_ sender: Any) {
        
        let username = usernameField.text!
        let password = passwordField.text!
        
        let alert = UIAlertController(title: "Wrong Password", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Try again", style: .default) { (action) in
        }
        
        PFUser.logInWithUsername(inBackground: username, password: password)
        { (user, error) in
            
            if user != nil {
                self.performSegue(withIdentifier: "loginSeque", sender: nil)
            } else {
                
                self.present(alert, animated: true, completion: nil)
                alert.addAction(action)
                print("Error: \(String(describing: error?.localizedDescription))")
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
}
