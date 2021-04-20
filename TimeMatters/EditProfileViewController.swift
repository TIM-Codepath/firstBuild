//
//  EditProfileViewController.swift
//  TimeMatters
//
//  Created by Chhoden Sherpa on 4/19/21.
//

import UIKit

class EditProfileViewController: UIViewController {
    
    
    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var bioInfo: UITextField!
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func onChangeProfilePhotoButton(_ sender: Any) {
    }
    
    
    @IBAction func onDoneButtonClick(_ sender: Any) {
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
