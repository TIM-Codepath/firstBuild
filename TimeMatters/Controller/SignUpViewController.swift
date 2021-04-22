//
//  SignUpViewController.swift
//  TimeMatters
//
//  Created by Berk Burak Tasdemir on 4/21/21.
//

import UIKit
import AlamofireImage
import Parse

class SignUpViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var bioField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var retypePassword: UITextField!
    @IBOutlet weak var profilePictureView: UIImageView!
    
    override func viewDidLoad() {
        profilePictureView.layer.cornerRadius = profilePictureView.frame.size.width/2
    }
    
    func showError(errorCode: Int) {
        var alertMessage = ""
        switch errorCode {
        case 201:
            alertMessage = "Password field cannot be empty."
            break
        case 2:
            alertMessage = "Password fields don't match."
            break
        case 3:
            alertMessage = "Username field cannot be empty."
            break
        case 142:
            alertMessage = "Name field cannot be empty."
            break
        default:
            break
        }
        let alert = UIAlertController(title: "Error", message: alertMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        self.present(alert, animated: true, completion: nil)
        alert.addAction(action)
    }
        
    func getErrorCode() -> Int {
        if passwordField.text?.isEmpty ?? true || retypePassword.text?.isEmpty ?? true {
            return 201
        }
        if passwordField.text != retypePassword.text {
            return 2
        }
        if usernameField.text?.isEmpty ?? true {
            return 3
        }
        if nameField.text?.isEmpty ?? true {
            return 142
        }
        return -1
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        let errorCode = getErrorCode()
        if errorCode != -1 {
            showError(errorCode: errorCode)
            return
        }
        
        let user = PFUser()
        user.username = usernameField.text
        user.password = passwordField.text
        user["name"] = nameField.text
        user["bio"] = bioField.text
        let imageData = profilePictureView.image!.pngData()
        let file = PFFileObject(data: imageData!)
        user["profile_photo"] = file
        user.signUpInBackground{(success, error) in
            if success {
                let view = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ProfileNavigationController") as! UINavigationController
                self.present(view, animated: true, completion: nil)
            } else {
                if let errorCode = error?._code {
                    self.showError(errorCode: errorCode)
                }
            }
        }
    }
    
    @IBAction func onUploadPhotoClick(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af.imageScaled(to: size)
        profilePictureView.image = scaledImage
        dismiss(animated: true, completion: nil)
    }
}
