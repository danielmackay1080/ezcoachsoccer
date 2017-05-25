//
//  ViewController.swift
//  EZCoachSoccer
//
//  Created by Daniel Mackay on 5/15/17.
//  Copyright © 2017 Daniel Mackay. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    var udef = UserDefaults.standard
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.rightBarButtonItem = nil
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func IamPlayer(_ sender: Any) {// sets value for player or coach
        udef.set(true, forKey: "IamPlayer")
        udef.set(false, forKey: "IamCoach")
    }

    @IBAction func IamCoach(_ sender: Any) {
        udef.set(false, forKey: "IamPlayer")
        udef.set(true, forKey: "IamCoach")
    }

}

