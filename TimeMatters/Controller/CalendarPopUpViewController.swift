//
//  CalendarPopUpViewController.swift
//  TimeMatters
//
//  Created by Berk Burak Tasdemir on 5/13/21.
//

import UIKit
import Parse

class CalendarPopUpViewController: UIViewController {
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var taskTextField: UITextField!
    
    var date: String?
    var delegate: CalendarDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popupView.layer.cornerRadius = 24
        self.view.alpha = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateIn()
    }
    
    @IBAction func onCancel(_ sender: Any) {
        animateOut()
    }
    
    @IBAction func onSave(_ sender: Any) {
        let task = PFObject(className: "CalendarTask")
        task["username"] = PFUser.current()?.username
        task["date"] = date
        task["task_name"] = taskTextField.text
        task.saveInBackground { (success, error) in
            if success {
                print("Task saved.")
                self.animateOut()
            }
        }
    }
    
    func animateIn() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn) {
            self.view.alpha = 1
        } completion: { (complete) in
            if complete {
                
            }
        }
    }
    
    func animateOut() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn) {
            self.view.alpha = 0
        } completion: { (complete) in
            if complete {
                self.dismiss(animated: false, completion: {
                    self.delegate?.getTasks()
                })
            }
        }
    }
}
