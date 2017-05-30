//
//  CoachLoginViewController.swift
//  EZCoachSoccer
//
//  Created by Daniel Mackay on 5/16/17.
//  Copyright © 2017 Daniel Mackay. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit

class CoachLoginViewController: UIViewController, FBSDKLoginButtonDelegate {
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var fbLogin: FBSDKLoginButton!
    
    var em = ""
    var pw = ""
    var dbRef : DatabaseReference?
    var firstLaunch = false
    var teamCode = ""
    var success = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        fbLogin.delegate = self
        firstLaunch = UserDefaults.standard.bool(forKey: "firstLaunch")
        if (!firstLaunch){
        Database.database().isPersistenceEnabled = true
            firstLaunch = true
            UserDefaults.standard.set(firstLaunch, forKey: "firstLaunch")
        }
        dbRef = Database.database().reference()
        let user  = Auth.auth().currentUser
        print("users \(user)")
        if (user != nil){
        self.dbRef?.child("users").child((user?.uid)!).observe(.value, with: { (snapshot) in
            let val = snapshot.value as? NSDictionary
            self.teamCode = val?["teamID"] as? String ?? ""
            DispatchQueue.main.async {
                if (self.teamCode.isEmpty){
                    self.success = false
                } else {
                    self.success = true
            }
            }
        })
            if (success){
                self.performSegue(withIdentifier: "loginToSetType", sender: self)
            } else {
                self.performSegue(withIdentifier: "toteamid", sender: self)
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // login with facebook
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if (ConnectionTest.isConnected()){
            if let err = error{
                showAlert(alertMessage: err.localizedDescription)
                return
            } else {
                if ((FBSDKAccessToken.current()) != nil){
                    print("my token" , FBSDKAccessToken.current().tokenString)
                    let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                    Auth.auth().signIn(with: credential) { (user, error) in
                       // print("firebase error" , error!)
                        if let err = error{
                            self.showAlert(alertMessage: err.localizedDescription)
                            return
                        }else {
                            
                        //self.dbRef?.child("users").child((FIRAuth.auth()?.currentUser?.uid)!).child("TeamCode").setValue(self.teamCode)
                            //user?.mutableSetValue(forKeyPath: "teamCode")
                            self.dbRef?.child("users").child((user?.uid)!).observe(.value, with: { (snapshot) in
                                let val = snapshot.value as? NSDictionary
                                self.teamCode = val?["teamID"] as? String ?? ""
                                DispatchQueue.main.async {
                                    if (self.teamCode.isEmpty){
                                        self.success = false
                                    } else {
                                        self.success = true
                                    }
                                }
                            })
                            if (self.success){
                                self.performSegue(withIdentifier: "toteamid", sender: self)
                            } else {
                                self.performSegue(withIdentifier: "loginToSetType", sender: self)
                                
                            }

                            
                        }

                    }
               
                }
            }
        } else {
            showAlert(alertMessage: "Unable to connect to the internet")
        }
        
    }
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        if (ConnectionTest.isConnected()){
        try! Auth.auth().signOut()
        } else {
            showAlert(alertMessage: "Unable to connect to the internet")
        }
    }
    
    @IBAction func createAcc(_ sender: Any) {
    }
    
    @IBAction func loginEmail(_ sender: Any) {// login email
        em = emailTxt.text!
        pw = passwordTxt.text!
        if (ConnectionTest.isConnected()){
        if (em.isEmpty || pw.isEmpty){
            showAlert(alertMessage: "Please enter your email and password")
        } else {
            Auth.auth().signIn(withEmail: em, password: pw, completion: { (user, error) in
                // ...
                if let err = error{
                    self.showAlert(alertMessage: err.localizedDescription)
                    return
                }else {
                    self.performSegue(withIdentifier: "loginToSetType", sender: self)
                }
            })
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
