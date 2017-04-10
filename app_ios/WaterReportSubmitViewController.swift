//
//  WaterReportSubmitViewController.swift
//  app_ios
//
//  Created by Nicholas Giammanco on 3/27/17.
//  Copyright © 2017 Nicholas Giammanco. All rights reserved.
//

import Foundation
import UIKit

class WaterReportSubmitViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var waterPicker: UIPickerView!
    @IBOutlet weak var idNum: UILabel!
    @IBOutlet weak var reporter: UILabel!
    @IBOutlet weak var date: UILabel!
    var pickerData: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let model = Model().getInstance()
        
        waterPicker.dataSource = self
        waterPicker.delegate = self
        
        let waterReport = WaterReport()
        pickerData = waterReport.getSources()
        let curAcc = model.getCurrentAccount()
        //TODO- Change to water report id
        idNum.text = String(waterReport.getId())
        reporter.text = curAcc.getEmailAddress()
        
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "EEE, d MMM yyyy, HH:mm"
        let now = dateformatter.string(from: Date())
        date.text = now
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }

}
