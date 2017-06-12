//
//  AddPlayerViewController.swift
//  EZCoachSoccer
//
//  Created by Daniel Mackay on 5/22/17.
//  Copyright © 2017 Daniel Mackay. All rights reserved.
//

import UIKit
import Firebase
import MessageUI

class AddPlayerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var addpl: UIButton!
    @IBOutlet weak var positionsTable: UITableView!
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
    var isUpdated : Bool?
    var updatedPlayer : Players?
    var section = ["Defenders", "Midfielders", "Atackers"]
    var posArr = [["GK", "LCB", "RCB", "CB", "RB", "LB" , "RWB", "LWB"], ["CM", "CDM" , "CAM", "LCM", "RCM", "LM", "RM", "LW", "RW"], ["ST", "CF", "LF", "RF", "LAM", "RAM"]]
    var firstSelect = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        let isUpdated = UserDefaults.standard.bool(forKey: "isUpdated")
        if (isUpdated){
            pfName.text = updatedPlayer?.pfName
            plName.text = updatedPlayer?.plName
            pos1.text = updatedPlayer?.pos1
            pos2.text = updatedPlayer?.pos2
            kitNum.text = updatedPlayer?.kitNum
            parentFN.text = updatedPlayer?.parentFN
            playerEM.text = updatedPlayer?.playerEm
            parentEm.text = updatedPlayer?.parentEm
            phoneNum.text = updatedPlayer?.phoneNum
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return section.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (!firstSelect){
            pos1.text = posArr[indexPath.section][indexPath.row]
            posArr[indexPath.section].remove(at: indexPath.row)
            tableView.reloadData()
            firstSelect = true
        } else {
            pos2.text = posArr[indexPath.section][indexPath.row]
            posArr[indexPath.section].remove(at: indexPath.row)
            tableView.reloadData()
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posArr[section].count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.section[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "positionsCell") as! PositionsTableViewCell
        cell.poslabel.text = posArr[indexPath.section][indexPath.row]
        return cell
    }
    
    @IBAction func addPlayer(_ sender: Any) { // adds player
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
            
                self.ref?.child("teams").child(self.tid).child("players").child(self.plfn+self.kn).setValue(playersDict)
                self.sendEmail(em1: self.plem, em2: self.parem, teamID: self.tid)
                
            })
        }
    }
    
    func showAlert(alertMessage: String){
        let alert = UIAlertController(title: "Alert", message: alertMessage, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func sendEmail(em1 : String, em2 : String, teamID : String){
        if (MFMailComposeViewController.canSendMail()){
           let email  = MFMailComposeViewController()
            email.mailComposeDelegate = self
            email.setToRecipients([em1, em2])
            email.setSubject("You have been added to a team via EZ Coach Soccer")
            email.setMessageBody("Hello your coach is using EZ Coach Soccer and has added you to his team, please download and sign in with this password \(self.tid)", isHTML: false)
            present(email, animated: true, completion: nil)
        }
    }

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
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
