//
//  UADailyViewController.swift
//  TimeMatters
//
//  Created by Aryum Jeon on 4/18/21.
//

import UIKit
import Charts
import Parse

class UADailyViewController: UIViewController, ChartViewDelegate {
    
    var radarChart = RadarChartView()
    let user = PFUser.current()!
    lazy var presets = (user["presets"] != nil) ? user["presets"] as! Array<String> : []
    lazy var timeLogs = (user["logs"] != nil) ? user["logs"] as! [String : [Int]] : [:]
    var presetIndex : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        radarChart.delegate = self
        // Do any additional setup after loading the view.
    }
    
//    func secondsToHours (timeValPair : Int) -> (Int) {
//      return (timeValPair / 3600)
//    }
    
    public func grabDataFromParse() -> Int
    {
        let presetID:String = presets[presetIndex]
        let stampedTime = timeLogs["\(presetID)"] as? [Int] ?? [0]
        var timeValPair : Int = 0
        var timeValPairInSec : Int = 0
        if(presetIndex < timeLogs.count)
        {
            timeValPair = stampedTime[0]
        } else
        {
            timeValPair = 0
        }
        presetIndex += 1
        timeValPairInSec = timeValPair/3600
        if(timeValPairInSec < 1 && timeValPair != 0)
        {
            timeValPairInSec = 1
        }
//        print("timeValPair\(timeValPair)")
//        print("timeValPairInSec\(timeValPairInSec)")

        return timeValPairInSec //one hour/60min * 1min/60 sec
    }

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        /**
         TODO:
         1. To retrieve timeLogs from Parse
         - learn mech of Dictionary <key, value> pair
         - try to print out anything from Parse - logs
         - learn how to return Dictionary <key, value> via map
         - try to print out anything from Parse - logs
         */
        
        //print(timeLogs["Study"]!) //prints 3
        
//        var val = timeLogs["Study"] //this needs to be in a loop to go through all the indexes instead of only looking at "Study"
                
//        for presetIndex in 0...timeLogs.count-1
//        {
//            print(presets[presetIndex])
//            let presetID:String = presets[presetIndex]
//            print(timeLogs["\(presetID)"]!)
////            print(timeLogs["\(presets[presetIndex]])")
//        }
        
        //input data management
        let cnt = presets.count
        var todayEntries : [RadarChartDataEntry]?
        var yesterdayEntries : [RadarChartDataEntry]?
        
//        print(timeLogs.count) //this prints 1
        
        var yesterdayDataBlock: (Int) -> RadarChartDataEntry = {_ in return
            RadarChartDataEntry(value: Double(arc4random_uniform(24/3)))
        }
        var todayDataBlock: (Int) -> RadarChartDataEntry = {_ in return
            RadarChartDataEntry(value: Double(self.grabDataFromParse()))
        }
        
        //daily reset of today's data to 0.
        UserDefaults.standard.set(false, forKey: "didLaunchBefore")
        if UserDefaults.standard.bool(forKey: "didLaunchBefore") == false{
          //only runs the first time your app is launched
                    UserDefaults.standard.set(true, forKey: "didLaunchBefore")
          //sets the initial value for tomorrow
                    let now = Calendar.current.dateComponents(in: .current, from: Date())
//            print("today is : \(now)")
                    let tomorrow = DateComponents(year: now.year, month: now.month, day: now.day! + 1, hour: now.hour, minute: now.minute, second: now.second)
//            print("tomorrow is : \(tomorrow)")
                    let date = Calendar.current.date(from: tomorrow)
                    UserDefaults.standard.set(date, forKey: "tomorrow")
                }
                if UserDefaults.standard.object(forKey: "tomorrow") != nil{
                    //makes sure tomorrow is not nil
                    if Date() > UserDefaults.standard.object(forKey: "tomorrow") as! Date {// if todays date is after(greater than) the 24 hour period you set last time you reset your values this will run
          // reseting "tomorrow" to the actual tomorrow
                        let now = Calendar.current.dateComponents(in: .current, from: Date())
                        let tomorrow = DateComponents(year: now.year, month: now.month, day: now.day! + 1, hour: now.hour, minute: now.minute, second: now.second)
                        let date = Calendar.current.date(from: tomorrow)
                        UserDefaults.standard.set(date, forKey: "tomorrow")
                        //reset values here
                        yesterdayDataBlock = todayDataBlock
                        user["logs"] = nil
                        user.saveInBackground()
                    }
                }

        todayEntries = (0..<cnt).map(todayDataBlock)
        yesterdayEntries = (0..<cnt).map(yesterdayDataBlock)
    
//        let block: (Int) -> RadarChartDataEntry = {_ in return
//            RadarChartDataEntry(value: Double(val![0])) //this will print out 3 - which is correct value from data base - but value needs to be converted down to seconds instead of hours.
//        }
//        let entries2 = (0..<cnt).map(block)
        
        //xAxis of RadarChart
        let xAxis = radarChart.xAxis
        xAxis.labelFont = .systemFont(ofSize: 9, weight:.bold)
        xAxis.labelTextColor = .lightGray
        xAxis.xOffset = 10
        //xAxis.xOffset = 10
        xAxis.valueFormatter = XAxisFormatter()
        
        //Radar Chart UI - 043021
        radarChart.webLineWidth = 1.5
        radarChart.innerWebLineWidth = 1.5
        radarChart.webColor = .lightGray
        radarChart.innerWebColor = .lightGray
        radarChart.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.width)
        //radarChart.legend.enabled = false
        radarChart.center = view.center
        view.addSubview(radarChart)
        
        //TODO: implement demo display without loop
//        entries.append(RadarChartDataEntry(value: 1))
//        entries.append(RadarChartDataEntry(value: 8))
//        entries.append(RadarChartDataEntry(value: 2))
//        entries.append(RadarChartDataEntry(value: 3))
//        entries.append(RadarChartDataEntry(value: 6))
//        entries1.append(RadarChartDataEntry(value: 4))
//        entries1.append(RadarChartDataEntry(value: 6))
//        entries1.append(RadarChartDataEntry(value: 5))
//        entries1.append(RadarChartDataEntry(value: 1))
//        entries1.append(RadarChartDataEntry(value: 8))
//        for x in 0..<5 {
//            entries.append(RadarChartDataEntry(value: Double(x), data: Double(x))
//        )}
        
        //Dataset management
        let todaySet = RadarChartDataSet(entries: todayEntries, label: "Today")
        let redColor = UIColor(red: 247/255, green: 67/255, blue: 115/255, alpha: 1)
        let redFillColor = UIColor(red: 247/255, green: 67/255, blue: 115/255, alpha: 1)
        todaySet.colors = [redColor]
        todaySet.fillColor = redFillColor
        todaySet.drawFilledEnabled = true
        //todaySet.valueFormatter = DataSetValueFormatter()
        let yesterdaySet = RadarChartDataSet(entries: yesterdayEntries, label: "Yesterday")
        let greyColor = UIColor(red: 103/255, green: 110/255, blue: 129/255, alpha: 1)
        let greyFillColor = UIColor(red: 103/255, green: 110/255, blue: 129/255, alpha: 1)
        yesterdaySet.colors = [greyColor]
        yesterdaySet.fillColor = greyFillColor
        yesterdaySet.fillAlpha = 0.7
        yesterdaySet.drawFilledEnabled = true
        yesterdaySet.valueFormatter = DataSetValueFormatter()
        
//        let testSet = RadarChartDataSet(entries: entries2, label: "Today")
//        yesterdaySet.colors = ChartColorTemplates.liberty()
//        todaySet.colors = ChartColorTemplates.colorful()

        let data = RadarChartData(dataSets: [yesterdaySet, todaySet])
        radarChart.data = data
    }
    
}

class XAxisFormatter: IAxisValueFormatter
{
//    let user = PFUser.current()!
    //let titles = "ABCDEFGHI".map{ "Party\($0)"}
    //let titles1 = "Break"
    //let titles = ["Study","Break","Exercise", "Work", "School"]
    let data = UADailyViewController()
    lazy var titles1 = data.presets
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        //titles[Int(value) % titles.count]
        //titles1
        titles1[Int(value) % titles1.count]
    }
}

class DataSetValueFormatter: IValueFormatter
{
    func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        ""
    }
}
