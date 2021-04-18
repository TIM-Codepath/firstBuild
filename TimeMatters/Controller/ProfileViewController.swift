//
//  ProfileViewController.swift
//  TimeMatters
//
//  Created by Aryum Jeon on 4/10/21.
//
import Parse
import UIKit

class ProfileViewController: UIViewController {

    
    @IBOutlet weak var user_name: UILabel!
    @IBOutlet weak var user_image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        user_name.text = PFUser.current()?.username
        // should change the user image here
        
        // Make image a circle
        user_image.layer.masksToBounds = true
        user_image.layer.cornerRadius = user_image.bounds.width / 2
        
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
    
    
    @IBAction func onLogoutButton(_ sender: Any) {
        
        
        PFUser.logOut()
               
//               let main = UIStoryboard(name: "Main", bundle: nil)
        let main = UIStoryboard(name: "AJ", bundle: nil)

               
               let loginViewContoller = main.instantiateViewController(withIdentifier: "LoginViewController")
               
               guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                     let delegate = windowScene.delegate as? SceneDelegate else {
                   return
               }
               delegate.window?.rootViewController = loginViewContoller
           }
    
}
