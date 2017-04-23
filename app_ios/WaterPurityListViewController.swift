//
//  WaterPurityListViewController.swift
//  app_ios
//
//  Created by Nicholas Giammanco on 4/22/17.
//  Copyright © 2017 Nicholas Giammanco. All rights reserved.
//

import Foundation
import UIKit

class WaterPurityListViewController: UIViewController {
    
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let model = Model.instance
        
        let reports = model.getPurityList()
        
        for rep in reports {
            textView.text = textView.text + "\n" + rep.toString()
        }
    }
}
