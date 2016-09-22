//
//  SoundsViewController.swift
//  Soothie Baby
//
//  Created by ramiro beltran on 9/12/16.
//  Copyright © 2016 Ramiro Beltran. All rights reserved.
//

import UIKit

class SoundsViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
    }
    
    @IBAction func newSoundButtonTapped(sender: AnyObject) {
        //go to new sound vc
        self.performSegueWithIdentifier(newSound_Segue, sender: self)
    }
    
    @IBAction func mySoundsButtonTapped(sender: AnyObject) {
        //go to my sounds vc
        
    }
    
    @IBAction func sharedSoundsButtonTapped(sender: AnyObject) {
        //go to shared sounds vc
        
    }
    
    @IBAction func backButtonTapped(sender: AnyObject) {
        //go back to main menu
        self.performSegueWithIdentifier(Menu_Segue, sender: self)
    }
    
}