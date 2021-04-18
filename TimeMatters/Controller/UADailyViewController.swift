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
        
        radarChart.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.width)
        
        radarChart.center = view.center
        view.addSubview(radarChart)
        var entries = [RadarChartDataEntry]()
        for x in 0..<10 {
            entries.append(RadarChartDataEntry(value: Double(x), data: Double(x))
        )}
        let set = RadarChartDataSet(entries:entries)
        
        set.colors = ChartColorTemplates.joyful()
        
        let data = RadarChartData(dataSet: set)
        radarChart.data = data
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
