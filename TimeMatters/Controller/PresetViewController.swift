//
//  PresetViewController.swift
//  TimeMatters
//
//  Created by Parsa Rahimi on 4/29/21.
//

import UIKit

class PresetViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var textField: UITextField!
    
    var presets:Array<String> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        
        presets = ["Study", "Work", "Exercise"] // TEMP
        
        navigationItem.title = "Presets"
        navigationItem.rightBarButtonItem = self.editButtonItem
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
