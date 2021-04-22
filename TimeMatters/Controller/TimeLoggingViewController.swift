//
//  TImerViewController.swift
//  TimeMatters
//
//  Created by Parsa Rahimi on 4/21/21.
//

import UIKit

class TimeLoggingViewController: UIViewController {
    
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var minuteLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var startStopBtn: UIButton!
    
    var timer = Timer()
    var isTimerActive = false;
    var timeElapsed = 0
    
    var (hours, minutes, seconds) = (0,0,0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startStopBtn.layer.masksToBounds = true
        startStopBtn.layer.cornerRadius = startStopBtn.bounds.width / 2
        
        initBarButton()
    }
    
    func initBarButton() {
        let button = UIButton(type: .system)
        button.setTitle("Add Preset", for: .normal)
        button.addTarget(self, action: #selector(clickAddPreset), for: .touchUpInside)
        self.navigationItem.setRightBarButton(UIBarButtonItem(customView: button), animated: true)
    }
    
    @objc func clickAddPreset() {
        print("clicked")
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
        print(timeElapsed) // TEMP
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
