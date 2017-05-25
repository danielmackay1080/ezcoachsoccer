//
//  AddPlayerViewController.swift
//  EZCoachSoccer
//
//  Created by Daniel Mackay on 5/22/17.
//  Copyright © 2017 Daniel Mackay. All rights reserved.
//

import UIKit
import Firebase

class AddPlayerViewController: UIViewController {

    @IBOutlet weak var pfName: UITextField!
    
    @IBOutlet weak var plName: UITextField!
    
    @IBOutlet weak var pos1: UITextField!
    
    @IBOutlet weak var pos2: UITextField!
    
    @IBOutlet weak var kitNum: UITextField!
    
    @IBOutlet weak var parentFN: UITextField!
    
    @IBOutlet weak var parentEm: UITextField!
    
    @IBOutlet weak var playerEM: UITextField!
    
    @IBOutlet weak var phoneNum: UITextField!
    
    var plfn = ""
    var plln = ""
    var ps1 = ""
    var ps2 = ""
    var kn = ""
    var parfn = ""
    var parem = ""
    var plem = ""
    var pn = ""
    var tid = ""
    
    var ref : DatabaseReference?
    var players = [Players]()
    var pld = [NSDictionary]()
    var udef = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addPlayer(_ sender: Any) {
        plfn = pfName.text!
        plln = plName.text!
        ps1 = pos1.text!
        ps2 = pos2.text!
        kn = kitNum.text!
        pn = phoneNum.text!
        parfn = parentFN.text!
        parem = parentEm.text!
        plem = playerEM.text!
        
        if (plfn.isEmpty || plln.isEmpty || ps1.isEmpty || kn.isEmpty || parfn.isEmpty || pn.isEmpty){
            showAlert(alertMessage: "Please fill all textfields with an *")
        } else if (parem.isEmpty && plem.isEmpty){
            showAlert(alertMessage: "Please enter an email address.")
        } else {
            players.append(Players(pfName: plfn, plName: plln, pos1: ps1, pos2: ps2, parentEm: parem, playerEm: plem, parentFN: parfn, kitNum: kn, phoneNum: pn))
            ref?.child("users").child((Auth.auth().currentUser?.uid)!).observe(.value, with: { (snapshot) in
                let val = snapshot.value as? NSDictionary
                self.tid = val?["teamID"] as? String ?? ""
                let playersDict = ["playerFirstName" : self.plfn, "playerLastName":self.plln, "position1" : self.ps1, "position2": self.ps2, "parentName":self.parfn, "playerEmail" : self.plem, "kitNumber" : self.kn, "parentEmail":self.parem, "phoneNumber": self.pn ]
                //let arrDict = [playersDict]
                //self.pld.append(playersDict as NSDictionary)
                //self.udef.set(self.pld, forKey: "plarrDict")
                //let par = self.udef.object(forKey: "plarrDict") as? [NSDictionary] ?? [NSDictionary]()
            
                self.ref?.child("teams").child(self.tid).child("players").childByAutoId().setValue(playersDict)
                self.navigationController?.popViewController(animated: true)
                
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
