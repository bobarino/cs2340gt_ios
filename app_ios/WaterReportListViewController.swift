//
//  WaterReportListViewController.swift
//  app_ios
//
//  Created by Nicholas Giammanco on 4/14/17.
//  Copyright © 2017 Nicholas Giammanco. All rights reserved.
//

import Foundation
import UIKit

class WaterReportListViewController: UIViewController {
    
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let model = Model.instance
        
        let reports = model.getReportList()
        
        for rep in reports {
            textView.text = textView.text + "\n" + rep.toString()
        }
        

    }
}
