//
//  CreateAccountViewController.swift
//  EZCoachSoccer
//
//  Created by Daniel Mackay on 5/16/17.
//  Copyright © 2017 Daniel Mackay. All rights reserved.
//

import UIKit
import Firebase

class CreateAccountViewController: UIViewController {
    
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var password1Txt: UITextField!
    @IBOutlet weak var password2Txt: UITextField!
    
    @IBOutlet weak var teamIDTxt: UITextField!
    @IBOutlet weak var nameTxt: UITextField!
    var em = ""
    var pw1 = ""
    var pw2 = ""
    var n  = ""
    var tid = ""
    var ref : DatabaseReference?
    var success = false

    override func viewDidLoad() {
        super.viewDidLoad()
            ref = Database.database().reference()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createAccount(_ sender: Any) { // creates account
        em = emailTxt.text!
        pw1 = password1Txt.text!
        pw2 = password2Txt.text!
        n = nameTxt.text!
        tid = teamIDTxt.text!
        if (em.isEmpty || pw1.isEmpty || pw2.isEmpty || n.isEmpty || tid.isEmpty){
            showAlert(alertMessage: "Please enter an email, a password, your name and a team ID.")
        } else {
            if (ConnectionTest.isConnected()){
            Auth.auth().createUser(withEmail: em, password: pw2, completion: { (user, error) in
                if let err = error{
                   self.showAlert(alertMessage: err.localizedDescription)
                    return
                } else {
                    self.ref?.child("teams").observe(.value, with: { (snapshot) in
                        DispatchQueue.main.async {
                        if (snapshot.hasChild(self.tid)){
                            self.success = false
                        } else {
                            self.ref?.child("users").child((user?.uid)!).child("teamID").setValue(self.tid)
                            self.ref?.child("teams").child(self.tid).child("coachName").setValue(self.n)
                            self.success = true
                        }
                        }
                    })

                    }
                if (self.success){
                    self.performSegue(withIdentifier: "crAcctoSetType", sender: self)
                } else {
                    self.showAlert(alertMessage: "Another user has already selected that teamID")
                }
            })
            } else {
                showAlert(alertMessage: "Unable to establish an internet connection.")
            }
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
