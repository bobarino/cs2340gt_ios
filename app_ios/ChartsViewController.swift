//
//  ChartsViewController.swift
//  app_ios
//
//  Created by Nicholas Giammanco on 4/24/17.
//  Copyright © 2017 Nicholas Giammanco. All rights reserved.
//

import Foundation
import SwiftCharts
import UIKit

class ChartsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    let model = Model.instance

        let chartConfig = BarsChartConfig(
            valsAxisConfig: ChartAxisConfig(from: 0, to: 100, by: 5)
        )

        let frame1 = CGRect(x: 0, y: 250, width: 150, height: 350)
        let frame2 = CGRect(x: 150, y: 250, width: 150, height: 350)
        
        let purList = model.getPurityList()
        var contaminantList = [(date: String, contaminant: Double)]()
        for c in purList {
            contaminantList.append((date: c.getDateTime(), contaminant: Double(c.getContaminantPPM())))
        }
        
        var viralList = [(date: String, viral: Double)]()
        for v in purList {
            viralList.append((date: v.getDateTime(), viral: Double(v.getViralPPM())))
        }

        let chart1 = BarsChart(
            frame: frame1,
            chartConfig: chartConfig,
            xTitle: "Date",
            yTitle: "ContaminantPPM",
            bars: contaminantList,
            color: UIColor.red,
            barWidth: 20
        )
        
        let chart2 = BarsChart(
            frame: frame2,
            chartConfig: chartConfig,
            xTitle: "Date",
            yTitle: "ViralPPM",
            bars: viralList,
            color: UIColor.blue,
            barWidth: 20
        )

        self.view.addSubview(chart1.view)
        self.view.addSubview(chart2.view)
    //self.chart = chart
    }
}
