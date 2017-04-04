//
//  WaterReportSubmitViewController.swift
//  app_ios
//
//  Created by Nicholas Giammanco on 3/27/17.
//  Copyright © 2017 Nicholas Giammanco. All rights reserved.
//

import Foundation
import UIKit

class WaterReportSubmitViewController: UIViewController {
    
    @IBOutlet weak var waterPicker: UIPickerView!
    let pickerData = WaterReport.waterSources
    override func viewDidLoad() {
        super.viewDidLoad()
        waterPicker.dataSource = self
        waterPicker.delegate = self
    }

}
