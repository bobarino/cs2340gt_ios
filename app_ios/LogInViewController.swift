//
//  LogInViewController.swift
//  app_ios
//
//  Created by Nicholas Giammanco on 2/28/17.
//  Copyright © 2017 Nicholas Giammanco. All rights reserved.
//

import UIKit

import Firebase
import FirebaseAuth

class LogInViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var textFieldLoginEmail: UITextField!
    @IBOutlet weak var textFieldLoginPassword: UITextField!
    
    /*@IBAction func loginDidTouch(sender: AnyObject) {
        if (textFieldLoginEmail.text == "hi" && textFieldLoginPassword.text == "yo") {
            self.performSegue(withIdentifier: "LoggedInSegue", sender: self)
        }
     }*/
    
    @IBAction func loginAction(_ sender: AnyObject) {
        let model = Model().getInstance()
        
        if self.textFieldLoginEmail.text == "" || self.textFieldLoginPassword.text == "" {
            
            //Alert to tell the user that there was an error because they didn't fill anything in the textfields because they didn't fill anything in
            
            let alertController = UIAlertController(title: "Error", message: "Please enter an email and password.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            
            FIRAuth.auth()?.signIn(withEmail: self.textFieldLoginEmail.text!, password: self.textFieldLoginPassword.text!) { (user, error) in
                
                if error == nil {
                    model.setCurrentAccount(currentAccount: model.findAccountByEmail(email: self.textFieldLoginEmail.text!));
                    print(model.getCurrentAccount().toString())
                    
                    //Print into the console if successfully logged in
                    print("You have successfully logged in")
                    
                    //Go to the HomeViewController if the login is sucessful
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoggedInViewController")
                    self.present(vc!, animated: true, completion: nil)
                    
                } else {
                    
                    //Tells the user that there is an error and then gets firebase to tell them the error
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
}

/*extension LogInViewController: UITextFieldDelegate {
 
 func textFieldShouldReturn(_ textField: UITextField) -> Bool {
 if textField == textFieldLoginEmail {
 textFieldLoginPassword.becomeFirstResponder()
 }
 if textField == textFieldLoginPassword {
 textField.resignFirstResponder()
 }
 return true
 }
 }*/
