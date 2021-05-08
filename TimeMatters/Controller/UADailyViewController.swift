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

    override func viewDidLoad() {
        super.viewDidLoad()
        radarChart.delegate = self
        // Do any additional setup after loading the view.
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //To retrieve an object
        var presets = (user["presets"] != nil) ? user["presets"] as! Array<String> : []
        
        print(presets)

        
        //input data management
        let cnt = 5
        let block: (Int) -> RadarChartDataEntry = {_ in return
            RadarChartDataEntry(value: Double(arc4random_uniform(24/3)))
        }
        var entries = (0..<cnt).map(block)
        var entries1 = (0..<cnt).map(block)
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
        let todaySet = RadarChartDataSet(entries: entries, label: "Today")
        let redColor = UIColor(red: 247/255, green: 67/255, blue: 115/255, alpha: 1)
        let redFillColor = UIColor(red: 247/255, green: 67/255, blue: 115/255, alpha: 1)
        todaySet.colors = [redColor]
        todaySet.fillColor = redFillColor
        todaySet.drawFilledEnabled = true
        //todaySet.valueFormatter = DataSetValueFormatter()
        let yesterdaySet = RadarChartDataSet(entries: entries1, label: "Yesterday")
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
    let titles = ["Study","Break","Exercise", "Work", "School"]
    
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        //titles[Int(value) % titles.count]
        //titles1
        titles[Int(value) % titles.count]
    }
}

class DataSetValueFormatter: IValueFormatter
{
    func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        ""
    }
}
