//
//  ViewTeamAndFormationsViewController.swift
//  EZCoachSoccer
//
//  Created by Daniel Mackay on 5/17/17.
//  Copyright © 2017 Daniel Mackay. All rights reserved.
//

import UIKit
import Firebase

class ViewTeamAndFormationsViewController: UITabBarController {
    
    var isPlayer : Bool?

    override func viewDidLoad() {
        super.viewDidLoad()
        isPlayer = UserDefaults.standard.bool(forKey: "IamPlayer")
                // Do any additional setup after loading the view.
        if (isPlayer! || (Auth.auth().currentUser?.isAnonymous)!){
            print("this is a player")
            self.viewControllers?.remove(at: 3)
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
