//
//  WaterPuritySubmitViewController.swift
//  app_ios
//
//  Created by Nicholas Giammanco on 4/17/17.
//  Copyright © 2017 Nicholas Giammanco. All rights reserved.
//


import Foundation
import UIKit
import FirebaseDatabase

class WaterPuritySubmitViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var conditionPicker: UIPickerView!
    @IBOutlet weak var idNum: UILabel!
    @IBOutlet weak var reporter: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var lat: UITextField!
    @IBOutlet weak var long: UITextField!
    @IBOutlet weak var viralPPM: UITextField!
    @IBOutlet weak var contaminantPPM: UITextField!
    var conditionData: [String] = [String]()
    var curAcc : Account!
    var condition : String!
    
    var ref: FIRDatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let model = Model.instance
        
        ref = FIRDatabase.database().reference()
        
        conditionPicker.dataSource = self
        conditionPicker.delegate = self
        
        let waterPurity = WaterPurityReport()
        conditionData = waterPurity.getConditions()
        
        curAcc = model.getCurrentAccount()
        idNum.text = String(waterPurity.getId())
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
        return conditionData.count;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        condition = conditionData[row]
        return conditionData[row]
    }
    
    @IBAction func submitPurity(_ sender: AnyObject) {
        let model = Model.instance
        let loc = Location(lat: Double(lat.text!)!, longit: Double(long.text!)!)
        let purity = WaterPurityReport(_reporter: curAcc, _condition: condition, _viralPPM: Int(viralPPM.text!)!, _contaminantPPM: Int(contaminantPPM.text!)!, _dateTime: date.text!, place: loc, emailAddress: curAcc.getEmailAddress())
        
        self.ref.child("purity_reports_ios").child(idNum.text!).setValue(purity.toAnyObject())
        { err, ref in
            print("Submitted!!!")
            model.addPurity(newPurity: purity)
        }
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoggedInViewController")
        self.present(vc!, animated: true, completion: nil)
        
    }
    
}
