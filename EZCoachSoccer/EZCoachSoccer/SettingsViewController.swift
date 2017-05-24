//
//  SettingsViewController.swift
//  EZCoachSoccer
//
//  Created by Daniel Mackay on 5/23/17.
//  Copyright © 2017 Daniel Mackay. All rights reserved.
//

import UIKit
import Firebase

class SettingsViewController: ViewController {
    
    @IBOutlet weak var editAccountButton: UIButton!
    @IBOutlet weak var deleteTeamButton: UIButton!
    var ref : FIRDatabaseReference?
    var isPlayer : Bool?

    override func viewDidLoad() {
        super.viewDidLoad()
        ref = FIRDatabase.database().reference()
        isPlayer = UserDefaults.standard.bool(forKey: "IamPlayer")
        if (isPlayer)!{
           editAccountButton.isHidden = true
            deleteTeamButton.isHidden = true
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func deleteAccount(_ sender: Any) {
        if (ConnectionTest.isConnected()){

        let user = FIRAuth.auth()?.currentUser
        
        user?.delete { error in
            if let error = error {
                self.showAlert(alertMessage: error.localizedDescription)
            } else {
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
        } else {
            showAlert(alertMessage: "Unable to connect to the internet")
        }
    }
    
    @IBAction func deleteTeam(_ sender: Any) {
        if (ConnectionTest.isConnected()){
        ref?.child("users").child((FIRAuth.auth()?.currentUser?.uid)!).observe(.value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let tid = value?["teamID"] as? String ?? ""
            
            self.ref?.child("teams").child(tid).removeValue()
            for vc in (self.navigationController?.viewControllers)! {
                if (vc.isKind(of: SetFieldTypeViewController.self)){
                    self.navigationController?.popToViewController(vc, animated: true)
                }
            }
            
        })
        } else {
            showAlert(alertMessage: "Unable to connect to the internet")
        }
    }
    
    @IBAction func editAccount(_ sender: Any) {
    }
   
    @IBAction func logout(_ sender: Any) {
        if (ConnectionTest.isConnected()){
            try! FIRAuth.auth()!.signOut()
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
