//
//  RegisterViewController.swift
//  app_ios
//
//  Created by Nicholas Giammanco on 3/5/17.
//  Copyright © 2017 Nicholas Giammanco. All rights reserved.
//

import UIKit

import Firebase
import FirebaseAuth
import FirebaseDatabase

class RegisterViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var ref: FIRDatabaseReference!
        
        ref = FIRDatabase.database().reference()
    }

    
    @IBOutlet weak var textFieldRegisterEmail: UITextField!
    @IBOutlet weak var textFieldRegisterPassword: UITextField!
    @IBOutlet weak var segController: UISegmentedControl!
    
    @IBAction func createAccountAction(_ sender: AnyObject) {
        
        if textFieldRegisterEmail.text == "" {
            let alertController = UIAlertController(title: "Error", message: "Please enter your email and password", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
            
        } else {
            var userType = Credential.USER
            switch segController.selectedSegmentIndex
            {
                case 0:
                    userType = Credential.USER;
                case 1:
                    userType = Credential.WORKER;
                case 2:
                    userType = Credential.MANAGER;
                case 3:
                    userType = Credential.ADMIN;
                default:
                    break;
            }
            
            FIRAuth.auth()?.createUser(withEmail: textFieldRegisterEmail.text!, password: textFieldRegisterPassword.text!) { (user, error) in
                
                if error == nil {
                    print("You have successfully signed up")
                    //Goes to the Setup page which lets the user take a photo for their profile picture and also chose a username
                    
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewController")
                    self.present(vc!, animated: true, completion: nil)
                    
                } else {
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
}
