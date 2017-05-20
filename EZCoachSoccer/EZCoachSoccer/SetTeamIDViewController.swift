//
//  SetTeamIDViewController.swift
//  EZCoachSoccer
//
//  Created by Daniel Mackay on 5/20/17.
//  Copyright © 2017 Daniel Mackay. All rights reserved.
//

import UIKit
import Firebase

class SetTeamIDViewController: UIViewController {
    
    @IBOutlet weak var eNameTxt: UITextField!
    @IBOutlet weak var eTidTxt: UITextField!
    
    var n = ""
    var tid = ""
    var ref  : FIRDatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
            ref = FIRDatabase.database().reference()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submit(_ sender: Any) {
        n = eNameTxt.text!
        tid = eTidTxt.text!
        if (n.isEmpty || tid.isEmpty){
            showAlert(alertMessage: "Please enter your name and a team ID to continue.")
        } else {
            
            ref?.child("users").child((FIRAuth.auth()?.currentUser?.uid)!).child("teamID").setValue(tid)
            ref?.child("users").child((FIRAuth.auth()?.currentUser?.uid)!).child("coachName").setValue(n)
            ref?.child("teams").child(tid).child("coachName").setValue(n)

        }
        
    }
    
    func showAlert(alertMessage: String){
        let alert = UIAlertController(title: "Alert", message: alertMessage, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
