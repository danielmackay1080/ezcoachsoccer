//
//  UpdateAccountViewController.swift
//  EZCoachSoccer
//
//  Created by Daniel Mackay on 5/23/17.
//  Copyright © 2017 Daniel Mackay. All rights reserved.
//

import UIKit
import Firebase

class UpdateAccountViewController: ViewController {
    
    @IBOutlet weak var upEmail: UITextField!
    
    @IBOutlet weak var upPw1: UITextField!

    @IBOutlet weak var upPw2: UITextField!
    
    @IBOutlet weak var upName: UITextField!
    
    var ue = ""
    var up1 = ""
    var up2 = ""
    var ut = ""
    var un = ""
    var ref : DatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        ref = Database.database().reference()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func updateAccount(_ sender: Any) { // updates account
        ue = upEmail.text!
        up1 = upPw1.text!
        up2 = upPw2.text!
        un = upName.text!
        
        if (ue.isEmpty || up1.isEmpty || up2.isEmpty || ut.isEmpty || un.isEmpty){
            showAlert(alertMessage: "Please enter the field you would like to update.")
        } else if (!ue.isEmpty){
            Auth.auth().currentUser?.updateEmail(to: ue) { (error) in
            }
        } else if (!up1.isEmpty || !up2.isEmpty && up1 == up2){
            Auth.auth().currentUser?.updatePassword(to: up2, completion: { (error) in
            })
        }  else if(!un.isEmpty){
            ref?.child("users").child((Auth.auth().currentUser?.uid)!).child("coachName").setValue(un)
            ref?.child("users").child((Auth.auth().currentUser?.uid)!).observe(.value, with: { (snapshot) in
                let value = snapshot.value as? NSDictionary
                let tid = value?["teamID"] as? String ?? ""
                self.ref?.child("teams").child(tid).child("coachName").setValue(self.un)
            })

        } else if (!ue.isEmpty){
            Auth.auth().currentUser?.updateEmail(to: ue, completion: { (error) in
            }
)
        }
        navigationController?.popViewController(animated: true)
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
