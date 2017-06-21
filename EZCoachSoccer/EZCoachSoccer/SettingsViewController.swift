//
//  SettingsViewController.swift
//  EZCoachSoccer
//
//  Created by Daniel Mackay on 5/23/17.
//  Copyright © 2017 Daniel Mackay. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit

class SettingsViewController: ViewController {
    
    @IBOutlet weak var editAccountButton: UIButton!
    @IBOutlet weak var deleteTeamButton: UIButton!
    var ref : DatabaseReference?
    var isPlayer : Bool?

    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        isPlayer = UserDefaults.standard.bool(forKey: "IamPlayer")
        if (isPlayer)!{
           editAccountButton.isHidden = true
            deleteTeamButton.isHidden = true
        }
        if (FBSDKAccessToken.current() != nil){
            editAccountButton.isHidden = true
        }
        _ = Auth.auth().currentUser
        //print("user provide \(user?.providerID)")
       
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func deleteAccount(_ sender: Any) { // delete account
        if (ConnectionTest.isConnected()){
            let delalert = UIAlertController(title: "Alert", message: "Are you sure you want to delete your account?", preferredStyle: UIAlertControllerStyle.alert)
            delalert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: { (action) in
                let user = Auth.auth().currentUser
                if (FBSDKAccessToken.current() != nil){
                    let loginMan = FBSDKLoginManager()
                    loginMan.logOut()
                }
                self.ref?.child("users").child((Auth.auth().currentUser?.uid)!).observeSingleEvent(of:.value, with: { (snapshot) in
                    
                    let value = snapshot.value as? NSDictionary
                    let tid = value?["teamID"] as? String ?? ""
                    self.ref?.child("teams").child(tid).removeValue()
                    self.ref?.child("users").child((user?.uid)!).removeValue()

                })
                user?.delete { error in
                    if let error = error {
                        self.showAlert(alertMessage: error.localizedDescription)
                    } else {
                        
                        self.navigationController?.popToRootViewController(animated: true)
                        //self.ref?.child("teams").child(tid).removeValue()
                        
                    }
                }

            }))
            
            delalert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))

            self.present(delalert, animated: true, completion: nil)

                } else {
            showAlert(alertMessage: "Unable to connect to the internet")
        }
    }
    
    @IBAction func deleteTeam(_ sender: Any) { // delete team
        if (ConnectionTest.isConnected()){
            
            let delTAlert = UIAlertController(title: "Alert", message: "Are you sure you want to delete your team?  ", preferredStyle: UIAlertControllerStyle.alert)
            delTAlert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: { (action) in
                self.ref?.child("users").child((Auth.auth().currentUser?.uid)!).observeSingleEvent(of:.value, with: { (snapshot) in
                    
                    let value = snapshot.value as? NSDictionary
                    let tid = value?["teamID"] as? String ?? ""
                    self.ref?.child("users").child((Auth.auth().currentUser?.uid)!).child("teamID").removeValue()
                    self.ref?.child("teams").child(tid).removeValue()
                    UserDefaults.standard.set(true, forKey: "teamDeleted")
                    DispatchQueue.main.async {
                        self.navigationController?.popToRootViewController(animated: true)
                        self.showAlert(alertMessage: "Your team has been deleted.")
                    }
                    //self.performSegue(withIdentifier: "deleteTeamSegue", sender: self)
                })

            }))
            delTAlert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
            self.present(delTAlert, animated: true, completion: nil)
            
        } else {
            showAlert(alertMessage: "Unable to connect to the internet")
        }
    }
    
    @IBAction func editAccount(_ sender: Any) {
            self.performSegue(withIdentifier: "toeditAcc", sender: self)
    }
   
    @IBAction func logout(_ sender: Any) { // logs user out
        if (ConnectionTest.isConnected()){
            if (FBSDKAccessToken.current() != nil){
                let loginMan = FBSDKLoginManager()
                loginMan.logOut()
            }
            try! Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } else {
            showAlert(alertMessage: "Unable to connect to the internet")
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
