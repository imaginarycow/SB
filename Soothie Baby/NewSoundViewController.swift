//
//  NewSoundViewController.swift
//  Soothie Baby
//
//  Created by ramiro beltran on 9/12/16.
//  Copyright © 2016 Ramiro Beltran. All rights reserved.
//

import UIKit


class NewSoundViewController: UIViewController {
    
    @IBOutlet var playButton: UIButton!
    @IBOutlet var shareButton: UIButton!
    @IBOutlet var stopButton: UIButton!
    @IBOutlet var timerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
    }
    
    @IBAction func playButtonTapped(sender: AnyObject) {
    }
    
    @IBAction func stopButtonTapped(sender: AnyObject) {
    }
    @IBAction func shareButtonTapped(sender: AnyObject) {
    }
    @IBAction func doneButtonTapped(sender: AnyObject) {
        self.performSegueWithIdentifier(Sound_Segue, sender: self)
    }
    
}