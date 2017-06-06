//
//  ElevenVElevenInterface.swift
//  EZCoachSoccer
//
//  Created by Daniel Mackay on 5/17/17.
//  Copyright © 2017 Daniel Mackay. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit
import CoreTelephony
import SystemConfiguration
import Firebase

public class ElevenVElevenInterface: SKScene{
    
    var gk11, lcb11, rcb11, rb11,lb11,rcm11,cm11,lcm11,rf11,lf11,str11,ball11, savePlays, savcf: SKSpriteNode?
    var opgk11, oplcb11, oprcb11, oprb11, oplb11,oprcm11,opcm11,oplcm11,oprf11,oplf11,opstr11 : SKSpriteNode?
    var spTitle, scTitle : SKLabelNode?
    
    // formation animations
    // 4-3-3
    var STR433 = SKAction.move(to: CGPoint(x: 96.203, y: -2.689), duration: 1)
    var rf433 = SKAction.move(to: CGPoint(x: 96.203, y: 222.311), duration: 1)
    var lf433 = SKAction.move(to: CGPoint(x: 96.203, y: -251.763), duration: 1)
    var rcm433 = SKAction.move(to: CGPoint(x: 273.203, y: -151.763), duration: 1)
    var lcm433 = SKAction.move(to: CGPoint(x: 273.203, y: 150.311), duration: 1)
    var cm433 = SKAction.move(to: CGPoint(x: 273.203, y: -2.689), duration: 1)
    var lb433 = SKAction.move(to: CGPoint(x: 405.203, y: -296.689), duration: 1)
    var rb433 = SKAction.move(to: CGPoint(x: 390.203, y: 288.311), duration: 1)
    var rcb433 = SKAction.move(to: CGPoint(x: 429.25, y: 98.786), duration: 1)
    var lcb433 = SKAction.move(to: CGPoint(x: 429.25, y: -101.214), duration: 1)
    
    // 4-4-2
    var lb442 = SKAction.move(to: CGPoint(x: 405.203, y: -296.689), duration: 1)
    var rb442 = SKAction.move(to: CGPoint(x: 390.203, y: 288.311), duration: 1)
    var rcb442 = SKAction.move(to: CGPoint(x: 429.25, y: 98.786), duration: 1)
    var lcb442 = SKAction.move(to: CGPoint(x: 429.25, y: -101.214), duration: 1)
    var rf442 = SKAction.move(to: CGPoint(x: 232.175, y: 269.69), duration: 1)
    var lcm442 = SKAction.move(to: CGPoint(x: 273.203, y: 97.311), duration: 1)
    var cm442 = SKAction.move(to: CGPoint(x: 273.203, y: -77.689), duration: 1)
    var rcm442 = SKAction.move(to: CGPoint(x: 243.005, y: -251.763), duration: 1)
    var str442 = SKAction.move(to: CGPoint(x: 92.203, y: 97.311), duration: 1)
    var lf442 = SKAction.move(to: CGPoint(x: 93.203, y: -62.966), duration: 1)
    
    // 4-2-3-1
    var lb4231 = SKAction.move(to: CGPoint(x: 405.203, y: -296.689), duration: 1)
    var rb4231 = SKAction.move(to: CGPoint(x: 390.203, y: 288.311), duration: 1)
    var rcb4231 = SKAction.move(to: CGPoint(x: 429.25, y: 98.786), duration: 1)
    var lcb4231 = SKAction.move(to: CGPoint(x: 429.25, y: -101.214), duration: 1)
    var cm4231 = SKAction.move(to: CGPoint(x: 302.203, y: -77.689), duration: 1)
    var lcm4231 = SKAction.move(to: CGPoint(x: 302.203, y: 72.311), duration: 1)
    var rf4231 = SKAction.move(to: CGPoint(x: 174.547, y: 201.214), duration: 1)
    var lf4231 = SKAction.move(to: CGPoint(x: 175.474, y: -2.689), duration: 1)
    var rcm4231 = SKAction.move(to: CGPoint(x: 175.474, y: -201.214), duration: 1)
    var str4231 = SKAction.move(to: CGPoint(x: 75.474, y: -2.689), duration: 1)
    
    // 3-4-3
    var rb343 = SKAction.move(to: CGPoint(x: 429.25, y: 198.786), duration: 1)
    var rcb343 = SKAction.move(to: CGPoint(x: 429.25, y: -15.739), duration: 1)
    var lcb343 = SKAction.move(to: CGPoint(x: 429.25, y: -215.739), duration: 1)
    var lf343 = SKAction.move(to: CGPoint(x: 266.727, y: -298.786), duration: 1)
    var lcm343 = SKAction.move(to: CGPoint(x: 266.727, y: 72.311), duration: 1)
    var cm343 = SKAction.move(to: CGPoint(x: 266.727, y: -102.689), duration: 1)
    var lb343 = SKAction.move(to: CGPoint(x: 266.727, y: 315.739), duration: 1)
    var str343 = SKAction.move(to: CGPoint(x: 75.474, y: -2.689), duration: 1)
    var rcm343 = SKAction.move(to: CGPoint(x: 75.474, y: -181.876), duration: 1)
    var rf343 = SKAction.move(to: CGPoint(x: 75.474, y: 172.311), duration: 1)
    
    // 5-3-2
    var rb532 = SKAction.move(to: CGPoint(x: 429.25, y: 198.786), duration: 1)
    var rcb532 = SKAction.move(to: CGPoint(x: 429.25, y: -15.739), duration: 1)
    var lcb532 = SKAction.move(to: CGPoint(x: 429.25, y: -215.739), duration: 1)
    var lb532 = SKAction.move(to: CGPoint(x: 350.551, y: -315.739), duration: 1)
    var lcm532 = SKAction.move(to: CGPoint(x: 264.828, y: 122.311), duration: 1)
    var cm532 = SKAction.move(to: CGPoint(x: 264.828, y: -15.739), duration: 1)
    var rcm532 = SKAction.move(to: CGPoint(x: 264.828, y: -170.077), duration: 1)
    var str532 = SKAction.move(to: CGPoint(x: 94.843, y: -81.876), duration: 1)
    var lf532 = SKAction.move(to: CGPoint(x: 350.551, y: 297.786), duration: 1)
    var rf532 = SKAction.move(to: CGPoint(x: 94.834, y: 50.311), duration: 1)
    
    var ref : DatabaseReference?
    var selectForm = ""
    var user : User?
    var isPlayer : Bool?

    
    public override func didMove(to view: SKView) {
        ball11 = childNode(withName: "ball11") as? SKSpriteNode!
        gk11 = childNode(withName: "gk11") as? SKSpriteNode!
        lcb11 = childNode(withName: "lcb11") as? SKSpriteNode!
        rcb11 = childNode(withName: "rcb11") as? SKSpriteNode!
        lb11 = childNode(withName: "lb11") as? SKSpriteNode!
        rb11 = childNode(withName: "rb11") as? SKSpriteNode!
        rcm11 = childNode(withName: "rcm11") as? SKSpriteNode!
        lcm11 = childNode(withName: "lcm11") as? SKSpriteNode!
        cm11 = childNode(withName: "cm11") as? SKSpriteNode!
        rf11 = childNode(withName: "rf11") as? SKSpriteNode!
        lf11 = childNode(withName: "lf11") as? SKSpriteNode!
        str11 = childNode(withName: "str11") as? SKSpriteNode!
        
        
        opgk11 = childNode(withName: "opgk11") as? SKSpriteNode!
        oplcb11 = childNode(withName: "oplcb11") as? SKSpriteNode!
        oprcb11 = childNode(withName: "oprcb11") as? SKSpriteNode!
        oprb11 = childNode(withName: "oprb11") as? SKSpriteNode!
        oplb11 = childNode(withName: "oplb11") as? SKSpriteNode!
        oprcm11 = childNode(withName: "oprcm11") as? SKSpriteNode!
        oplcm11 = childNode(withName: "oplcm11") as? SKSpriteNode!
        opcm11 = childNode(withName: "opcm11") as? SKSpriteNode!
        oprf11 = childNode(withName: "oprf11") as? SKSpriteNode!
        oplf11 = childNode(withName: "oplf11") as? SKSpriteNode!
        opstr11 = childNode(withName: "opstr11") as? SKSpriteNode!
        savePlays = childNode(withName: "saveplaybg11") as! SKSpriteNode!
        spTitle = childNode(withName: "saveplaylabel11") as! SKLabelNode!
        scTitle = childNode(withName: "savecflabel11") as! SKLabelNode!
        savcf = childNode(withName: "savecfbg11") as! SKSpriteNode!
        savePlays?.isHidden = true
        spTitle?.isHidden = true
        scTitle?.isHidden = true
        savcf?.isHidden = true

        isPlayer = UserDefaults.standard.bool(forKey: "IamPlayer")
        ref = Database.database().reference()
        user = Auth.auth().currentUser
        if (user != nil){
            ref?.child("users").child((user?.uid)!).observeSingleEvent(of:.value, with: { (snapshot) in
                let val = snapshot.value as? NSDictionary
                let teamCode = val?["teamID"] as? String ?? ""
                self.ref?.child("teams").child(teamCode).observeSingleEvent(of: .value, with: { (snapshot) in
                    let val2 = snapshot.value as? NSDictionary
                    self.selectForm = val2?["selectedFormation"] as? String ?? ""
                    let ft = val2?["fieldType"] as? String ?? ""
                    if (self.selectForm == "4-3-3"){
                        self.form433()
                    } else if (self.selectForm == "4-2-3-1") {
                        self.form4231()
                    } else if (self.selectForm == "4-4-2"){
                        self.form442()
                    } else if (self.selectForm == "3-4-3"){
                        self.form343()
                    } else if (self.selectForm == "5-3-2"){
                        self.form532()
                    } else if (snapshot.childSnapshot(forPath: "customFormations").childSnapshot(forPath: ft).hasChild(self.selectForm)){
                        
                        let lcbx = snapshot.childSnapshot(forPath:"customFormations").childSnapshot(forPath: ft).childSnapshot(forPath: self.selectForm).childSnapshot(forPath: (self.lcb11?.name)!).childSnapshot(forPath: "x") .value as! CGFloat
                        let lcby = snapshot.childSnapshot(forPath:"customFormations").childSnapshot(forPath: ft).childSnapshot(forPath: self.selectForm).childSnapshot(forPath: (self.lcb11?.name)!).childSnapshot(forPath: "y") .value as! CGFloat
                        let rcbx = snapshot.childSnapshot(forPath:"customFormations").childSnapshot(forPath: ft).childSnapshot(forPath: self.selectForm).childSnapshot(forPath: (self.rcb11?.name)!).childSnapshot(forPath: "x") .value as! CGFloat
                        let rcby = snapshot.childSnapshot(forPath:"customFormations").childSnapshot(forPath: ft).childSnapshot(forPath: self.selectForm).childSnapshot(forPath: (self.rcb11?.name)!).childSnapshot(forPath: "y") .value as! CGFloat
                        let lfx = snapshot.childSnapshot(forPath:"customFormations").childSnapshot(forPath: ft).childSnapshot(forPath: self.selectForm).childSnapshot(forPath: (self.lf11?.name)!).childSnapshot(forPath: "x") .value as! CGFloat
                        let lfy = snapshot.childSnapshot(forPath:"customFormations").childSnapshot(forPath: ft).childSnapshot(forPath: self.selectForm).childSnapshot(forPath: (self.lf11?.name)!).childSnapshot(forPath: "y") .value as! CGFloat
                        let rfx = snapshot.childSnapshot(forPath:"customFormations").childSnapshot(forPath: ft).childSnapshot(forPath: self.selectForm).childSnapshot(forPath: (self.rf11?.name)!).childSnapshot(forPath: "x") .value as! CGFloat
                        let rfy = snapshot.childSnapshot(forPath:"customFormations").childSnapshot(forPath: ft).childSnapshot(forPath: self.selectForm).childSnapshot(forPath: (self.rf11?.name)!).childSnapshot(forPath: "y") .value as! CGFloat
                        let cmx = snapshot.childSnapshot(forPath:"customFormations").childSnapshot(forPath: ft).childSnapshot(forPath: self.selectForm).childSnapshot(forPath: (self.cm11?.name)!).childSnapshot(forPath: "x") .value as! CGFloat
                        let cmy = snapshot.childSnapshot(forPath:"customFormations").childSnapshot(forPath: ft).childSnapshot(forPath: self.selectForm).childSnapshot(forPath: (self.cm11?.name)!).childSnapshot(forPath: "y") .value as! CGFloat
                        let strx = snapshot.childSnapshot(forPath:"customFormations").childSnapshot(forPath: ft).childSnapshot(forPath: self.selectForm).childSnapshot(forPath: (self.str11?.name)!).childSnapshot(forPath: "x") .value as! CGFloat
                        let stry = snapshot.childSnapshot(forPath:"customFormations").childSnapshot(forPath: ft).childSnapshot(forPath: self.selectForm).childSnapshot(forPath: (self.str11?.name)!).childSnapshot(forPath: "y") .value as! CGFloat
                        let lcmx = snapshot.childSnapshot(forPath:"customFormations").childSnapshot(forPath: ft).childSnapshot(forPath: self.selectForm).childSnapshot(forPath: (self.lcm11?.name)!).childSnapshot(forPath: "x") .value as! CGFloat
                        let lcmy = snapshot.childSnapshot(forPath:"customFormations").childSnapshot(forPath: ft).childSnapshot(forPath: self.selectForm).childSnapshot(forPath: (self.lcm11?.name)!).childSnapshot(forPath: "y") .value as! CGFloat
                        let rcmx = snapshot.childSnapshot(forPath:"customFormations").childSnapshot(forPath: ft).childSnapshot(forPath: self.selectForm).childSnapshot(forPath: (self.rcm11?.name)!).childSnapshot(forPath: "x") .value as! CGFloat
                        let rcmy = snapshot.childSnapshot(forPath:"customFormations").childSnapshot(forPath: ft).childSnapshot(forPath: self.selectForm).childSnapshot(forPath: (self.rcm11?.name)!).childSnapshot(forPath: "y") .value as! CGFloat
                        let lbx = snapshot.childSnapshot(forPath:"customFormations").childSnapshot(forPath: ft).childSnapshot(forPath: self.selectForm).childSnapshot(forPath: (self.lb11?.name)!).childSnapshot(forPath: "x") .value as! CGFloat
                        let lby = snapshot.childSnapshot(forPath:"customFormations").childSnapshot(forPath: ft).childSnapshot(forPath: self.selectForm).childSnapshot(forPath: (self.lb11?.name)!).childSnapshot(forPath: "y") .value as! CGFloat
                        let rbx = snapshot.childSnapshot(forPath:"customFormations").childSnapshot(forPath: ft).childSnapshot(forPath: self.selectForm).childSnapshot(forPath: (self.rb11?.name)!).childSnapshot(forPath: "x") .value as! CGFloat
                        let rby = snapshot.childSnapshot(forPath:"customFormations").childSnapshot(forPath: ft).childSnapshot(forPath: self.selectForm).childSnapshot(forPath: (self.rb11?.name)!).childSnapshot(forPath: "y") .value as! CGFloat
                        
                        print("lcbx \(lcbx)")
                        
                        self.lcb11?.run(SKAction.move(to: CGPoint(x: lcbx, y: lcby), duration: 0.5))
                        self.rcb11?.run(SKAction.move(to: CGPoint(x: rcbx, y: rcby), duration: 0.5))
                        self.rf11?.run(SKAction.move(to: CGPoint(x: rfx, y: rfy), duration: 0.5))
                        self.lf11?.run(SKAction.move(to: CGPoint(x: lfx, y: lfy), duration: 0.5))
                        self.cm11?.run(SKAction.move(to: CGPoint(x: cmx, y: cmy), duration: 0.5))
                        self.str11?.run(SKAction.move(to: CGPoint(x: strx, y: stry), duration: 0.5))
                        self.rcm11?.run(SKAction.move(to: CGPoint(x: rcmx, y: rcmy), duration: 0.5))
                        self.lcm11?.run(SKAction.move(to: CGPoint(x: lcmx, y: lcmy), duration: 0.5))
                        self.rb11?.run(SKAction.move(to: CGPoint(x: rbx, y: rby), duration: 0.5))
                        self.lb11?.run(SKAction.move(to: CGPoint(x: lbx, y: lby), duration: 0.5))
                        
                    }

                    
                })
            })
        }

    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (!isPlayer!){
            spTitle?.isHidden = false
            savePlays?.isHidden = false
            savcf?.isHidden = false
            scTitle?.isHidden = false
        }
        for t in touches{
            let loc = t.location(in: self)
            if (savePlays?.contains(loc))!{
                saveSetPlay()
            }
            if (savcf?.contains(loc))!{
                SaveCustomFormation(alertMessage: "Save Custom Formation")
            }
        }
        
    }

    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let tl = touch.location(in: self)
            if let node = self.atPoint(tl) as? SKSpriteNode{
                if (node.name == ball11?.name){
                    ball11?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == gk11?.name){
                    gk11?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == lcb11?.name){
                    lcb11?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == rcb11?.name){
                    rcb11?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == lb11?.name){
                    lb11?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == rb11?.name){
                    rb11?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == rcm11?.name){
                    rcm11?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == lcm11?.name){
                    lcm11?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == cm11?.name){
                    cm11?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == rf11?.name){
                    rf11?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == lf11?.name){
                    lf11?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == str11?.name){
                    str11?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == opgk11?.name){
                    opgk11?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == oplcb11?.name){
                    oplcb11?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == oprcb11?.name){
                    oprcb11?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == oprb11?.name){
                    oprb11?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == oplb11?.name){
                    oplb11?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == oprcm11?.name){
                    oprcm11?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == oplcm11?.name){
                    oplcm11?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == opcm11?.name){
                    opcm11?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == oprf11?.name){
                    oprf11?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == oplf11?.name){
                    oplf11?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == opstr11?.name){
                    opstr11?.position = CGPoint(x: tl.x, y: tl.y)
                }
            }
        }
    }
    
    func form433(){
        lcb11?.run(lcb433)
        rcb11?.run(rcb433)
        rb11?.run(rb433)
        lb11?.run(lb433)
        cm11?.run(cm433)
        rcm11?.run(rcm433)
        lcm11?.run(lcm433)
        lf11?.run(lf433)
        rf11?.run(rf433)
        str11?.run(STR433)
    }
    
    func form442(){
        lcb11?.run(lcb442)
        rcb11?.run(rcb442)
        lb11?.run(lb442)
        rb11?.run(rb442)
        cm11?.run(cm442)
        rcm11?.run(rcm442)
        lcm11?.run(lcm442)
        lf11?.run(lf442)
        rf11?.run(rf442)
        str11?.run(str442)
    }
    
    func form4231(){
        lcb11?.run(lcb4231)
        rcb11?.run(rcb4231)
        rb11?.run(rb4231)
        lb11?.run(lb4231)
        cm11?.run(cm4231)
        rcm11?.run(rcm4231)
        lcm11?.run(lcm4231)
        rf11?.run(rf4231)
        lf11?.run(lf4231)
        str11?.run(str4231)
    }
    
    func form343(){
        lcb11?.run(lcb343)
        rcb11?.run(rcb343)
        lb11?.run(lb343)
        rb11?.run(rb343)
        cm11?.run(cm343)
        rcm11?.run(rcm343)
        lcm11?.run(lcm343)
        rf11?.run(rf343)
        lf11?.run(lf343)
        str11?.run(str343)
    }
    
    func form532(){
        lcb11?.run(lcb532)
        rcb11?.run(rcb532)
        rb11?.run(rb532)
        lb11?.run(lb532)
        cm11?.run(cm532)
        lcm11?.run(lcm532)
        rcm11?.run(rcm532)
        rf11?.run(rf532)
        lf11?.run(lf532)
        str11?.run(str532)
    }
    
    func saveSetPlay(){
        print("savesetplay")
        let scrShot = self.view?.takeScreenShot11()
        UIImageWriteToSavedPhotosAlbum(scrShot!, nil, nil, nil)
        
        savePlay(alertMessage: "Save a play", image: scrShot!)
    }
    
    func savePlay(alertMessage: String, image : UIImage){
        print("show alert")
        let alert = UIAlertController(title: "Alert", message: alertMessage, preferredStyle: UIAlertControllerStyle.alert)
        alert.addTextField { (textfield) in
            textfield.text = "Set Play 1"
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { [weak alert] (_) in
            self.ref?.child("users").child((self.user?.uid)!).observeSingleEvent(of:.value, with: { (snapshot) in
                let val = snapshot.value as? NSDictionary
                let teamCode = val?["teamID"] as? String ?? ""
                let ft = val?["fieldType"] as? String ?? ""
                let playName = alert?.textFields?[0].text!
                print("playnAME\(String(describing: playName))")
                let sref = Storage.storage().reference().child(teamCode).child(ft).child("plays").child(playName!)
                if let uploadData = UIImagePNGRepresentation(image){
                    _ = sref.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                        if let err = error{
                            print("imageerror \(err)")
                            return
                        } else {
                            let url = metadata!.downloadURL()
                            self.ref?.child("teams").child(teamCode).child("plays").child(ft).child(playName!).child("url").setValue(url?.absoluteString)
                            self.ref?.child("teams").child(teamCode).child("plays").child(ft).child(playName!).child("title").setValue(playName!)
                        }
                    })
                }
                
            })
            
        }))
        //self.view?.window.present(alert, animated: true, completion: nil)
        self.view?.window?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    func SaveCustomFormation(alertMessage : String){
        let alert = UIAlertController(title: "Alert", message: alertMessage, preferredStyle: UIAlertControllerStyle.alert)
        alert.addTextField { (textfield) in
            textfield.text = "Custom Formation 1"
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { [weak alert] (_) in
            self.ref?.child("users").child((self.user?.uid)!).observeSingleEvent(of:.value, with: { (snapshot) in
                let val = snapshot.value as? NSDictionary
                let teamCode = val?["teamID"] as? String ?? ""
                let ft = val?["fieldType"] as? String ?? ""
                let fName = alert?.textFields?[0].text!
                print("cf\(String(describing: fName))")
                self.ref?.child("teams").child(teamCode).child("customFormations").child(ft).child(fName!).child("title").setValue(fName!)
                self.ref?.child("teams").child(teamCode).child("customFormations").child(ft).child(fName!).child((self.lcb11?.name)!).child("x").setValue(self.lcb11?.position.x)
                self.ref?.child("teams").child(teamCode).child("customFormations").child(ft).child(fName!).child((self.lcb11?.name)!).child("y").setValue(self.lcb11?.position.y)
                self.ref?.child("teams").child(teamCode).child("customFormations").child(ft).child(fName!).child((self.rcb11?.name)!).child("x").setValue(self.rcb11?.position.x)
                self.ref?.child("teams").child(teamCode).child("customFormations").child(ft).child(fName!).child((self.rcb11?.name)!).child("y").setValue(self.rcb11?.position.y)
                self.ref?.child("teams").child(teamCode).child("customFormations").child(ft).child(fName!).child((self.lb11?.name)!).child("x").setValue(self.lb11?.position.x)
                self.ref?.child("teams").child(teamCode).child("customFormations").child(ft).child(fName!).child((self.lb11?.name)!).child("y").setValue(self.lb11?.position.y)
                self.ref?.child("teams").child(teamCode).child("customFormations").child(ft).child(fName!).child((self.rb11?.name)!).child("x").setValue(self.rb11?.position.x)
                self.ref?.child("teams").child(teamCode).child("customFormations").child(ft).child(fName!).child((self.rb11?.name)!).child("y").setValue(self.rb11?.position.y)
                self.ref?.child("teams").child(teamCode).child("customFormations").child(ft).child(fName!).child((self.lcm11?.name)!).child("x").setValue(self.lcm11?.position.x)
                self.ref?.child("teams").child(teamCode).child("customFormations").child(ft).child(fName!).child((self.lcm11?.name)!).child("y").setValue(self.lcm11?.position.y)
                self.ref?.child("teams").child(teamCode).child("customFormations").child(ft).child(fName!).child((self.rcm11?.name)!).child("x").setValue(self.rcm11?.position.x)
                self.ref?.child("teams").child(teamCode).child("customFormations").child(ft).child(fName!).child((self.rcm11?.name)!).child("y").setValue(self.rcm11?.position.y)
                self.ref?.child("teams").child(teamCode).child("customFormations").child(ft).child(fName!).child((self.cm11?.name)!).child("x").setValue(self.cm11?.position.x)
                self.ref?.child("teams").child(teamCode).child("customFormations").child(ft).child(fName!).child((self.cm11?.name)!).child("y").setValue(self.cm11?.position.y)
                self.ref?.child("teams").child(teamCode).child("customFormations").child(ft).child(fName!).child((self.lf11?.name)!).child("x").setValue(self.lf11?.position.x)
                self.ref?.child("teams").child(teamCode).child("customFormations").child(ft).child(fName!).child((self.lf11?.name)!).child("y").setValue(self.lf11?.position.y)
                self.ref?.child("teams").child(teamCode).child("customFormations").child(ft).child(fName!).child((self.rf11?.name)!).child("x").setValue(self.rf11?.position.x)
                self.ref?.child("teams").child(teamCode).child("customFormations").child(ft).child(fName!).child((self.rf11?.name)!).child("y").setValue(self.rf11?.position.y)
                self.ref?.child("teams").child(teamCode).child("customFormations").child(ft).child(fName!).child((self.str11?.name)!).child("x").setValue(self.str11?.position.x)
                self.ref?.child("teams").child(teamCode).child("customFormations").child(ft).child(fName!).child((self.str11?.name)!).child("y").setValue(self.str11?.position.y)
            })
            
        }))
        //self.view?.window.present(alert, animated: true, completion: nil)
        self.view?.window?.rootViewController?.present(alert, animated: true, completion: nil)
    }


}
extension UIView{
    
    func takeScreenShot11 () -> UIImage{
        print("take screen shot")
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
        
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
        
    }
    
}

