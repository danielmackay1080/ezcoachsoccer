//
//  ForgotPasswordViewController.swift
//  EZCoachSoccer
//
//  Created by Daniel Mackay on 5/22/17.
//  Copyright © 2017 Daniel Mackay. All rights reserved.
//

import UIKit
import Firebase

class ForgotPasswordViewController: ViewController {
    
    
    @IBOutlet weak var email: UITextField!
    
    var em = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func submit(_ sender: Any) {
        em = email.text!
                if (em.isEmpty){
            showAlert(alertMessage: "Please enter an email to reset your password.")
        } else {
            Auth.auth().sendPasswordReset(withEmail: em, completion: { error in
                if let error = error{
                    self.showAlert(alertMessage: error.localizedDescription)
                } else {
                    self.showAlert(alertMessage: "A password reset email has been sent to \(self.em)")
                    self.navigationController?.popViewController(animated: true)
                }
            })
        }
        
    }
    
    func showAlert(alertMessage: String){
        let alert = UIAlertController(title: "Alert", message: alertMessage, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
