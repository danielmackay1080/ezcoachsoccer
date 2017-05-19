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
    var dbRef : FIRDatabaseReference?
    var firstLaunch = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        fbLogin.delegate = self
        firstLaunch = UserDefaults.standard.bool(forKey: "firstLaunch")
        if (!firstLaunch){
        FIRDatabase.database().persistenceEnabled = true
            firstLaunch = true
            UserDefaults.standard.set(firstLaunch, forKey: "firstLaunch")
        }
        dbRef = FIRDatabase.database().reference()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if (ConnectionTest.isConnected()){
            if let err = error{
                showAlert(alertMessage: err.localizedDescription)
                return
            } else {
                if ((FBSDKAccessToken.current()) != nil){
                    print("my token" , FBSDKAccessToken.current().tokenString)
                    let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                    FIRAuth.auth()?.signIn(with: credential) { (user, error) in
                       // print("firebase error" , error!)
                        if let err = error{
                            self.showAlert(alertMessage: err.localizedDescription)
                            return
                        }else {
                            let teamCode = "myteam\(Int(arc4random_uniform(1000)))"
                        self.dbRef?.child("users").child((FIRAuth.auth()?.currentUser?.uid)!).child("TeamCode").setValue(teamCode)
                            self.performSegue(withIdentifier: "loginToSetType", sender: self)
                            
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
        try! FIRAuth.auth()!.signOut()
        } else {
            showAlert(alertMessage: "Unable to connect to the internet")
        }
    }
    
    @IBAction func createAcc(_ sender: Any) {
    }
    
    @IBAction func loginEmail(_ sender: Any) {
        em = emailTxt.text!
        pw = passwordTxt.text!
        if (ConnectionTest.isConnected()){
        if (em.isEmpty || pw.isEmpty){
            showAlert(alertMessage: "Please enter your email and password")
        } else {
            FIRAuth.auth()?.signIn(withEmail: em, password: pw, completion: { (user, error) in
                // ...
                if let err = error{
                    self.showAlert(alertMessage: err.localizedDescription)
                    return
                }else {
                    
                }
            })
        }
        }
    }
    
    @IBOutlet weak var forgetPw: UIButton!
    
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
