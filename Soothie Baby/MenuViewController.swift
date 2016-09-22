//
//  ViewController.swift
//  Soothie Baby
//
//  Created by ramiro beltran on 9/12/16.
//  Copyright © 2016 Ramiro Beltran. All rights reserved.
//

import UIKit
import Firebase

let data = NSUserDefaults.standardUserDefaults()
var viewHasBeenSeen = false

class MenuViewController: UIViewController, UITextFieldDelegate {
    
    var hasRun = data.boolForKey("hasRun")
    
    
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var pictureButton: UIButton!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var pinField: UITextField!
    @IBOutlet var autoLogin: UISwitch!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setAutoLoginButton()
        checkForNewInstall()
        
    }
    
    @IBAction func autoLoginChanged(sender: AnyObject) {
        
        if autoLogin.on {
            data.setBool(true, forKey: "autoLogin")
        }else {
            data.setBool(false, forKey: "autoLogin")
        }
        data.synchronize()
    }
    
    func setAutoLoginButton() {
        
        if data.boolForKey("autoLogin") == true {
            autoLogin.on = true
        }else {
            autoLogin.on = false
        }
    }
    
    @IBAction func loginButtonTapped(sender: AnyObject) {
        
        //register first time user
        if data.boolForKey("hasRun") == false {
            
            registerNewUser()
            
        }
        //login existing user
        else {
            
            loginUser()
            
        }
        
        
    }
    
    func loginUser() {
        
        let email = data.stringForKey("email")!
        let password = data.stringForKey("password")!
        
        FIRAuth.auth()?.signInWithEmail(email, password: password) { (user, error) in
            
            if error != nil {
                self.showInvalidAlert("existing user login failed", message: "")
            }
            else {
                self.performSegueWithIdentifier(Sound_Segue, sender: self)
            }
        }
    }
    
    func registerNewUser() {
        
        let email = emailField.text!
        let password = pinField.text!
        
        let validation = validateUserCredentials(email, password: password)
        
        //validate user input
        if validation == false{
            showInvalidAlert("invalid credentials", message: "")
            
        } else {
            
            //attempt to register username with firebase if username available
            FIRAuth.auth()?.createUserWithEmail(email, password: password) { (user, error) in
                
                if error != nil {
                    print("error: \(error)")
                    self.showInvalidAlert("New Register Failed", message: "")
                }
                else {
                    //set email and password in user defaults
                    data.setObject(email, forKey: "email")
                    data.setObject(password, forKey: "password")
                    data.setBool(true, forKey: "hasRun")
                    data.synchronize()
                    self.checkForNewInstall()
                    
                    //show loading icon
                    //when successful present picture taker
                    viewHasBeenSeen = true
                    self.performSegueWithIdentifier(Sound_Segue, sender: self)
                }
            }
            
        }

    }
    
    func validateUserCredentials(email: String, password: String) -> Bool{
        var isValid = true
        
        if email.isEmpty || password.isEmpty{
            isValid = false
        }
        
        return isValid
    }
    
    func presentPictureTaker() {
        
        
    }
    
    func showInvalidAlert(title:String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func checkForNewInstall() {
        
        if hasRun == false {
            //login button.text = register
            // attempt new user register
            loginButton.setTitle("Register", forState: .Normal)
            pictureButton.hidden = true
            pictureButton.enabled = false
        }
        else {
            loginButton.setTitle("Login", forState: .Normal)
            pictureButton.hidden = false
            pictureButton.enabled = true
            
            emailField.text = data.stringForKey("email")
            pinField.text = data.stringForKey("password")
            
            //automatically login existing user
            if autoLogin.on && viewHasBeenSeen == false{
                viewHasBeenSeen = true
                loginUser()
            }
        }
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    /**
     * Called when the user click on the view (outside the UITextField).
     */
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

