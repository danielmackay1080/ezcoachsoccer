//
//  PlayerLoginViewController.swift
//  EZCoachSoccer
//
//  Created by Daniel Mackay on 5/16/17.
//  Copyright © 2017 Daniel Mackay. All rights reserved.
//

import UIKit
import Firebase

class PlayerLoginViewController: UIViewController {

    @IBOutlet weak var teamCodeTxt: UITextField!
    var tc = ""
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
    
    @IBAction func playerLoginButton(_ sender: Any) {
        tc = teamCodeTxt.text!
        if (ConnectionTest.isConnected()){
        if (tc.isEmpty){
            showAlert(alertMessage: "You must enter a team code to login")
        } else{
            Auth.auth().signInAnonymously(completion:  { (user, error) in // player login
                // ...
                //user?.providerData.
                if let error = error{
                    print("playererror \(error.localizedDescription)")
                } else {
                self.ref?.child("teams").observe(.value, with: { (snapshot) in
                    if (snapshot.hasChild(self.tc)){
                        let ft = snapshot.childSnapshot(forPath: self.tc).childSnapshot(forPath: "fieldType").value
                        self.ref?.child("users").child((Auth.auth().currentUser?.uid)!).child("teamID").setValue(self.tc)
                        self.ref?.child("users").child((Auth.auth().currentUser?.uid)!).child("fieldType").setValue(ft)
                        DispatchQueue.main.async {
                            self.success = true
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.success = false
                        }
                        try! Auth.auth().signOut()
                        Auth.auth().currentUser?.delete(completion: { error in
                        })
                        return
                    }
                })
            }
            })
            if (success){
                self.performSegue(withIdentifier: "playerlogintofield", sender: self)
            } else {
                self.showAlert(alertMessage: "This team has not been registered please try again.")
            }
        }
    }else {
            showAlert(alertMessage: "Unable to establish an internet connection")
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
