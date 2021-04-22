//
//  EditProfileViewController.swift
//  TimeMatters
//
//  Created by Chhoden Sherpa on 4/19/21.
//

import UIKit
import Parse
import AlamofireImage

class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var bioTextfield: UITextField!
    @IBOutlet weak var profileImage: UIImageView!
    
    var name: String? {
        didSet {
            nameTextfield.text = name
        }
    }
    
    var bio: String? {
        didSet {
            bioTextfield.text = bio
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImage.layer.cornerRadius = profileImage.frame.size.width/2
        let user = PFUser.current()
        if let imageFile = user?["profile_photo"] as? PFFileObject {
            let urlString = imageFile.url!
            let url = URL(string: urlString)!
            profileImage.af.setImage(withURL: url)
        }
        name = user?["name"] as? String
        bio = user?["bio"] as? String
    }
    

    @IBAction func onChangeProfilePhotoButton(_ sender: Any) {
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
        profileImage.image = scaledImage
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onDoneButtonClick(_ sender: Any) {
        let user = PFUser.current()
        user?["name"] = nameTextfield.text
        user?["bio"] = bioTextfield.text
        let imageData = profileImage.image!.pngData()
        let file = PFFileObject(data: imageData!)
        user?["profile_photo"] = file
        user?.saveInBackground {(success, error) in
            if success {
                self.navigationController?.popViewController(animated: true)
            } else {
                print(error?.localizedDescription)
            }
        }
    }
}
