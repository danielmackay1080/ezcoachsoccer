//
//  SetTeamIDViewController.swift
//  EZCoachSoccer
//
//  Created by Daniel Mackay on 5/20/17.
//  Copyright © 2017 Daniel Mackay. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit

class SetTeamIDViewController: UIViewController {
    
    @IBOutlet weak var eNameTxt: UITextField!
    @IBOutlet weak var eTidTxt: UITextField!
    
    var n = ""
    var tid = ""
    var ref  : DatabaseReference?
    var success = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
            ref = Database.database().reference()
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "name"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    //print("fb result \(result)")
                    //result.
                    let data = result as! [String : AnyObject]
                    self.eNameTxt.text = data["name"] as? String
                }
            })
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submit(_ sender: Any) { // sets a unique team id
        n = eNameTxt.text!
        tid = eTidTxt.text!
        if (n.isEmpty || tid.isEmpty){
            showAlert(alertMessage: "Please enter your name and a team ID to continue.")
        } else {
            self.ref?.child("teams").observeSingleEvent(of:.value, with: { (snapshot) in
                DispatchQueue.main.async {
                if (snapshot.hasChild(self.tid)){
                   
                        self.success = false
                } else {
                    //self.success = true
                    self.ref?.child("users").child((Auth.auth().currentUser?.uid)!).child("teamID").setValue(self.tid)
                    self.ref?.child("users").child((Auth.auth().currentUser?.uid)!).child("coachName").setValue(self.n)
                    self.ref?.child("teams").child(self.tid).child("coachName").setValue(self.n)
                    
                        self.success = true
                }
                    if (self.success){
                        self.performSegue(withIdentifier: "fromteamidtofieldtype", sender: self)
                    } else {
                        self.showAlert(alertMessage: "Another user has selected this Team ID please try again")
                    }

                }
            })
            
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
