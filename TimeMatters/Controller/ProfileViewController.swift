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
    @IBOutlet weak var timeLoggingView: UIStackView!
    @IBOutlet weak var productivityView: UIStackView!
    @IBOutlet weak var userAttributesView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        user_name.text = PFUser.current()?.username
        // should change the user image here
        
        // Make image a circle
        user_image.layer.masksToBounds = true
        user_image.layer.cornerRadius = user_image.bounds.width / 2
        
        initViews()
    }
    
    func initViews() {
        let productivityGesture = UITapGestureRecognizer(target: self, action: #selector(self.productibityTab(_:)))
        productivityView.addGestureRecognizer(productivityGesture)
        
        let userAttributesGesture = UITapGestureRecognizer(target: self, action: #selector(self.userAttributesTab(_:)))
        userAttributesView.addGestureRecognizer(userAttributesGesture)
    }
    
    @objc func productibityTab(_ sender: UITapGestureRecognizer? = nil) {
        let storyboard: UIStoryboard = UIStoryboard(name: "ProductivityStoryboard", bundle:nil)
        let view  = storyboard.instantiateViewController(withIdentifier: "calendarView") as! CalendarViewController
        self.navigationController?.pushViewController(view, animated: true)
    }
    
    @objc func userAttributesTab(_ sender: UITapGestureRecognizer? = nil) {
        let storyboard: UIStoryboard = UIStoryboard(name: "UserAttributesStoryboard", bundle:nil)
        let view  = storyboard.instantiateViewController(withIdentifier: "tabBarControl") as! UITabBarController
        self.navigationController?.pushViewController(view, animated: true)
    }
    
    @IBAction func onLogoutButton(_ sender: Any) {
        
        
        PFUser.logOut()
               
               let main = UIStoryboard(name: "Main", bundle: nil)
//        let main = UIStoryboard(name: "AJ", bundle: nil)

               
               let loginViewContoller = main.instantiateViewController(withIdentifier: "LoginViewController")
               
               guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                     let delegate = windowScene.delegate as? SceneDelegate else {
                   return
               }
               delegate.window?.rootViewController = loginViewContoller
           }
    
}
