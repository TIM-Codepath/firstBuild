//
//  UADailyViewController.swift
//  TimeMatters
//
//  Created by Aryum Jeon on 4/18/21.
//

import UIKit
import Charts

class UADailyViewController: UIViewController, ChartViewDelegate {
    
    var radarChart = RadarChartView()

    override func viewDidLoad() {
        super.viewDidLoad()
        radarChart.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let xAxis = radarChart.xAxis
        xAxis.valueFormatter = XAxisFormatter()
        xAxis.labelFont = .systemFont(ofSize: 9, weight:.bold)
        
        
        radarChart.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.width)
        
        radarChart.center = view.center
        view.addSubview(radarChart)
        var entries = [RadarChartDataEntry]()
        for x in 0..<5 {
            entries.append(RadarChartDataEntry(value: Double(x), data: Double(x))
        )}
        let set = RadarChartDataSet(entries:entries)

        set.colors = ChartColorTemplates.colorful()
        
        let data = RadarChartData(dataSet: set)
        radarChart.data = data
    }
    
}

class XAxisFormatter: IAxisValueFormatter
{
    //let titles = "ABCDEFGHI".map{ "Party\($0)"}
    let titles1 = "Break"
    let titles2 = "Study"

    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        //titles[Int(value) % titles.count]
        titles1
    }
}
