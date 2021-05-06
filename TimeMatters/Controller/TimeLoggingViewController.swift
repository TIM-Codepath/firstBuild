//
//  TImerViewController.swift
//  TimeMatters
//
//  Created by Parsa Rahimi on 4/21/21.
//

import UIKit
import Parse

class TimeLoggingViewController: UIViewController {
    
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var minuteLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var startStopBtn: UIButton!
    
    @IBOutlet weak var currentPreset: UILabel!
    @IBOutlet weak var prevPresetBtn: UIButton!
    @IBOutlet weak var nextPresetBtn: UIButton!
    
    var presets:Array<String> = []
    var timeLogs: [String: [Int]] = [:]
    var presetIndex = 0
    
    var timer = Timer()
    var isTimerActive = false;
    var timeElapsed = 0
    
    var (hours, minutes, seconds) = (0,0,0)
    
    let user = PFUser.current()!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startStopBtn.layer.masksToBounds = true
        startStopBtn.layer.cornerRadius = startStopBtn.bounds.width / 2
        
        initBarButton()
        
        timeLogs = (user["logs"] != nil) ? user["logs"] as! [String : [Int]] : [:]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presetIndex = 0
        presets = (user["presets"] != nil) ? user["presets"] as! Array<String> : []
        
        if !presets.isEmpty {
            startStopBtn.isHidden = false
            setPreset()
        } else {
            currentPreset.text = "No Presets"
            nextPresetBtn.isEnabled = false
            prevPresetBtn.isEnabled = false
            startStopBtn.isHidden = true
        }
    }
    
    private func setPreset() {
        currentPreset.text = presets[presetIndex]
        
        nextPresetBtn.isEnabled = presets.indices.contains(presetIndex+1);
        prevPresetBtn.isEnabled = presets.indices.contains(presetIndex-1);

    }
    
    @IBAction func decrementPreset(_ sender: Any) {
        presetIndex -= 1
        setPreset()
    }
    
    @IBAction func incrementPreset(_ sender: Any) {
        presetIndex += 1
        setPreset()
    }
    
    func initBarButton() {
        let button = UIButton(type: .system)
        button.setTitle("Manage Presets", for: .normal)
        button.titleLabel?.font = button.titleLabel?.font.withSize(17)
        button.addTarget(self, action: #selector(clickAddPreset), for: .touchUpInside)
        self.navigationItem.setRightBarButton(UIBarButtonItem(customView: button), animated: true)
    }
    
    @objc func clickAddPreset() {
        let storyboard: UIStoryboard = UIStoryboard(name: "TimeLoggingStoryboard", bundle:nil)
        let view  = storyboard.instantiateViewController(withIdentifier: "presetViewController") as! PresetViewController
        self.navigationController?.pushViewController(view, animated: true)
    }
    
    @IBAction func onStartStop(_ sender: Any) {
        if !isTimerActive {
            start()
            startStopBtn.backgroundColor = UIColor(red: 0.88, green: 0.24, blue: 0.18, alpha: 1.00)
            startStopBtn.setTitle("Stop", for: .normal)
            isTimerActive = true;
        } else {
            stop()
            startStopBtn.backgroundColor = UIColor(red: 0.01, green: 0.71, blue: 0.36, alpha: 1.00)
            startStopBtn.setTitle("Start", for: .normal)
            isTimerActive = false;
        }
    }
    
    func start() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(TimeLoggingViewController.keepTimer), userInfo: nil, repeats: true)
    }
    
    func stop() {
        timer.invalidate()
        (hours, minutes, seconds) = (0,0,0)
        hourLabel.text = "00"
        minuteLabel.text = "00"
        secondLabel.text = "00"
        
        // Save the time elapsed to database
        if timeLogs[currentPreset.text!] == nil {
            timeLogs[currentPreset.text!] = []
        }
        timeLogs[currentPreset.text!]!.append(timeElapsed)
        user["logs"] = timeLogs
        user.saveInBackground()
        timeElapsed = 0
    }
    
    @objc func keepTimer() {
        
        seconds += 1
        
        if seconds == 60 {
            minutes += 1
            seconds = 0
        }
        
        if minutes == 60 {
            hours += 1
            minutes = 0
        }
        
        hourLabel.text = hours > 9 ? "\(hours)" : "0\(hours)"
        minuteLabel.text = minutes > 9 ? "\(minutes)" : "0\(minutes)"
        secondLabel.text = seconds > 9 ? "\(seconds)" : "0\(seconds)"
        
        timeElapsed += 1
        
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
