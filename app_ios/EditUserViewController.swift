//
//  EditUserViewController.swift
//  app_ios
//
//  Created by Nicholas Giammanco on 4/23/17.
//  Copyright © 2017 Nicholas Giammanco. All rights reserved.
//

import UIKit

import Firebase
import FirebaseAuth
import FirebaseDatabase

class EditUserViewController: UIViewController {
    
    var ref: FIRDatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        ref = FIRDatabase.database().reference()
    }
    
    
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    
    @IBAction func createAccountAction(_ sender: AnyObject) {
        let model = Model.instance
        
        if textFieldEmail.text == "" {
            let alertController = UIAlertController(title: "Error", message: "Please enter your email and password", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
            
        } else {
            FIRAuth.auth()?.currentUser?.updateEmail(textFieldEmail.text!) { (error) in
                
                FIRAuth.auth()?.currentUser?.updatePassword(self.textFieldPassword.text!) { (error) in
                    
                    model.getCurrentAccount().setEmailAddress(emailAddress: self.textFieldEmail.text!)
                    model.getCurrentAccount().setPassword(password: self.textFieldPassword.text!)
                    
                self.ref.child("accounts_ios").child(String(model.getCurrentAccount().getId())).child("emailAddress").setValue(self.textFieldEmail.text!)
                    { err, ref in
                        print("Email Data Changed")
                    }
                self.ref.child("accounts_ios").child(String(model.getCurrentAccount().getId())).child("password").setValue(self.textFieldPassword.text!)
                    { err, ref in
                        print("Password Data Changed")
                    }

                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoggedInViewController")
                    self.present(vc!, animated: true, completion: nil)
                }
            }
        }
    }
    
}
