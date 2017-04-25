//
//  WaterReportSubmitViewController.swift
//  app_ios
//
//  Created by Nicholas Giammanco on 3/27/17.
//  Copyright © 2017 Nicholas Giammanco. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase

class WaterReportSubmitViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var waterPicker: UIPickerView!
    @IBOutlet weak var conditionPicker: UIPickerView!
    @IBOutlet weak var idNum: UILabel!
    @IBOutlet weak var reporter: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var lat: UITextField!
    @IBOutlet weak var long: UITextField!
    var pickerData: [String] = [String]()
    var conditionData: [String] = [String]()
    var curAcc : Account!
    var source : String!
    var condition : String!
    
    var ref: FIRDatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let model = Model.instance
        
        ref = FIRDatabase.database().reference()
        
        waterPicker.dataSource = self
        waterPicker.delegate = self
        
        conditionPicker.dataSource = self
        conditionPicker.delegate = self
        
        let waterReport = WaterReport()
        pickerData = waterReport.getSources()
        conditionData = waterReport.getConditions()
        
        curAcc = model.getCurrentAccount()
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
        if pickerView == waterPicker {
            return pickerData.count;
        } else if pickerView == conditionPicker {
            return conditionData.count;
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == waterPicker {
            source = pickerData[row]
            return pickerData[row]
        } else if pickerView == conditionPicker {
            condition = conditionData[row]
            return conditionData[row]
        }
        return ""
    }
    
    @IBAction func submitReport(_ sender: AnyObject) {
        let model = Model.instance
        let loc = Location(lat: Double(lat.text!)!, longit: Double(long.text!)!)
        let report = WaterReport(_reporter: curAcc, _source: source, _condition: condition, _dateTime: date.text!, place: loc, emailAddress: curAcc.getEmailAddress())
        
        self.ref.child("reports_ios").child(idNum.text!).setValue(report.toAnyObject())
        { err, ref in
            print("Submitted!!!")
            model.addReport(newReport: report)
        }
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoggedInViewController")
        self.present(vc!, animated: true, completion: nil)

    }

}
