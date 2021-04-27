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
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var user_image: UIImageView!
    @IBOutlet weak var timeLoggingView: UIStackView!
    @IBOutlet weak var productivityView: UIStackView!
    @IBOutlet weak var userAttributesView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Make image a circle
        user_image.layer.masksToBounds = true
        user_image.layer.cornerRadius = user_image.bounds.width / 2
        
        initViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        initModel()
    }
    
    func initModel() {
        let user = PFUser.current()
        
        if let name = user?["name"] as? String {
            user_name.text = name
        } else {
            user_name.text = user?.username
        }
        
        if let bio = user?["bio"] as? String {
            bioLabel.text = bio
        } else {
            bioLabel.text = ""
        }
        
        if let imageFile = user?["profile_photo"] as? PFFileObject {
            let urlString = imageFile.url!
            let url = URL(string: urlString)!
            user_image.af.setImage(withURL: url)
        }
    }
    
    func initViews() {
        let timeLoggingGesture = UITapGestureRecognizer(target: self, action: #selector(self.timeLoggingTab(_:)))
        timeLoggingView.addGestureRecognizer(timeLoggingGesture)
        
        let productivityGesture = UITapGestureRecognizer(target: self, action: #selector(self.productivityTab(_:)))
        productivityView.addGestureRecognizer(productivityGesture)
        
        let userAttributesGesture = UITapGestureRecognizer(target: self, action: #selector(self.userAttributesTab(_:)))
        userAttributesView.addGestureRecognizer(userAttributesGesture)
    }
    
    @objc func timeLoggingTab(_ sender: UITapGestureRecognizer? = nil) {
        let storyboard: UIStoryboard = UIStoryboard(name: "TimeLoggingStoryboard", bundle:nil)
        let view  = storyboard.instantiateViewController(withIdentifier: "timeLoggingViewController") as! TimeLoggingViewController
        self.navigationController?.pushViewController(view, animated: true)
    }
    
    @objc func productivityTab(_ sender: UITapGestureRecognizer? = nil) {
        let storyboard: UIStoryboard = UIStoryboard(name: "ProductivityStoryboard", bundle:nil)
        let view  = storyboard.instantiateViewController(withIdentifier: "calendarView") as! CalendarViewController
        self.navigationController?.pushViewController(view, animated: true)
    }
    
    @objc func userAttributesTab(_ sender: UITapGestureRecognizer? = nil) {
        let storyboard: UIStoryboard = UIStoryboard(name: "UserAttributesStoryboard", bundle:nil)
        let view  = storyboard.instantiateViewController(withIdentifier: "tabBarControl") as! UITabBarController
        self.navigationController?.pushViewController(view, animated: true)
    }
    

    
}
