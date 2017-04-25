//
//  ViewController.swift
//  app_ios
//
//  Created by Nicholas Giammanco on 2/9/17.
//  Copyright © 2017 Nicholas Giammanco. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let model = Model.instance
        if (model.getAccountList().count == 0 && model.getReportList().count == 0 && model.getPurityList().count == 0) {
            model.setup_accounts(model: model)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

