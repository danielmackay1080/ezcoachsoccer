//
//  SetFieldTypeViewController.swift
//  EZCoachSoccer
//
//  Created by Daniel Mackay on 5/16/17.
//  Copyright © 2017 Daniel Mackay. All rights reserved.
//

import UIKit
import Firebase

class SetFieldTypeViewController: UIViewController {
    
    var udef = UserDefaults.standard
    var ref : DatabaseReference!
    var user = Auth.auth().currentUser

    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // selects field type
    @IBAction func v5(_ sender: Any) {
        if (user != nil){
        udef.set(true, forKey: "isFive")
        udef.set(false, forKey: "isNine")
        udef.set(false, forKey: "isSeven")
        udef.set(false, forKey: "isEleven")
        ref.child("users").child((user?.uid)!).child("fieldType").setValue("5v5")
            ref.child("users").child((user?.uid)!).observeSingleEvent(of:.value, with: { (snapshot) in
                let val = snapshot.value as? NSDictionary
                let tid = val?["teamID"] as? String ?? ""
                self.ref.child("teams").child(tid).child("fieldType").setValue("5v5")
            })
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "selecttypetofield", sender: self)
            }
            
        }
    }

    @IBAction func v7(_ sender: Any) {
        if (user != nil){
        udef.set(false, forKey: "isFive")
        udef.set(false, forKey: "isNine")
        udef.set(true, forKey: "isSeven")
        udef.set(false, forKey: "isEleven")
            ref.child("users").child((user?.uid)!).child("fieldType").setValue("7v7")
            ref.child("users").child((user?.uid)!).observeSingleEvent(of:.value, with: { (snapshot) in
                let val = snapshot.value as? NSDictionary
                let tid = val?["teamID"] as? String ?? ""
                self.ref.child("teams").child(tid).child("fieldType").setValue("7v7")
                
            })
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "selecttypetofield", sender: self)
            }

        }
    }
   
     @IBAction func v9(_ sender: Any) {
        if (user != nil){
        udef.set(false, forKey: "isFive")
        udef.set(true, forKey: "isNine")
        udef.set(false, forKey: "isSeven")
        udef.set(false, forKey: "isEleven")
            ref.child("users").child((user?.uid)!).child("fieldType").setValue("9v9")
            ref.child("users").child((user?.uid)!).observeSingleEvent(of:.value, with: { (snapshot) in
                let val = snapshot.value as? NSDictionary
                let tid = val?["teamID"] as? String ?? ""
                self.ref.child("teams").child(tid).child("fieldType").setValue("9v9")
                
            })
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "selecttypetofield", sender: self)
            }

        }
     }
    
    @IBAction func v11(_ sender: Any) {
        if (user != nil){
        udef.set(false, forKey: "isFive")
        udef.set(false, forKey: "isNine")
        udef.set(false, forKey: "isSeven")
        udef.set(true, forKey: "isEleven")
            ref.child("users").child((user?.uid)!).child("fieldType").setValue("11v11")
            ref.child("users").child((user?.uid)!).observeSingleEvent(of:.value, with: { (snapshot) in
                let val = snapshot.value as? NSDictionary
                let tid = val?["teamID"] as? String ?? ""
                self.ref.child("teams").child(tid).child("fieldType").setValue("11v11")

            })
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "selecttypetofield", sender: self)
            }
        }
    }
}
