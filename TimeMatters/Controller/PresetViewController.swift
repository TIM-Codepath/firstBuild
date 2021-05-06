//
//  PresetViewController.swift
//  TimeMatters
//
//  Created by Parsa Rahimi on 4/29/21.
//

import UIKit
import Parse

class PresetViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var textField: UITextField!
    
    var presets:Array<String> = []
    
    let user = PFUser.current()!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        
        presets = (user["presets"] != nil) ? user["presets"] as! Array<String> : []
        
        navigationItem.title = "Presets"
        navigationItem.leftBarButtonItem = self.editButtonItem
        navigationItem.rightBarButtonItems = [UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(goBack)), UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(goBackWithNoSave))]
    }
    
    @objc func goBackWithNoSave() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func goBack() {
        self.user["presets"] = self.presets
        user.saveInBackground { (success, error) in
            if success {
                self.navigationController?.popViewController(animated: true)
            } else {
                let alert = UIAlertController(title: "Something went wrong", message: "The preset could not be saved", preferredStyle: .alert)
                let action = UIAlertAction(title: "Dismiss", style: .default) { (action) in}
                self.present(alert, animated: true, completion: nil)
                alert.addAction(action)
                print("Error: \(String(describing: error?.localizedDescription))")
            }
        }
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        self.tableView.setEditing(editing, animated: true)
    }
    
    @IBAction func addPreset(_ sender: Any) {
        let alertCtrl = UIAlertController(title: "Add Preset", message: "", preferredStyle: .alert)
        
        // Add text field to alert controller
        alertCtrl.addTextField { (textField) in
            self.textField = textField
            self.textField.autocapitalizationType = .words
            self.textField.placeholder = "e.g. Play"
        }
        
        // Add cancel button to alert controller
        alertCtrl.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        // "Add" button with callback
        alertCtrl.addAction(UIAlertAction(title: "Add", style: .default, handler: { action in
            if let preset = self.textField.text, preset != "" {
                self.presets.append(preset)
                self.tableView.reloadData()
            }
        }))
        
        present(alertCtrl, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "preset", for: indexPath)
        cell.textLabel?.text = presets[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presets.count
    }
    
    // Organize
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedObject = presets[sourceIndexPath.row]
        presets.remove(at: sourceIndexPath.row)
        presets.insert(movedObject, at: destinationIndexPath.row)
    }
    
    // Delete
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.presets.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
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
    
}
