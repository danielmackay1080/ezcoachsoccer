//
//  FiveVFiveInterface.swift
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
import UIKit

public class FiveVFiveInterface: SKScene{
    
    var gk5 : SKSpriteNode?
    var opGk5 : SKSpriteNode?
    var lcb5 : SKSpriteNode?
    var oplcb5 : SKSpriteNode?
    var rcb5 : SKSpriteNode?
    var oprcb5 : SKSpriteNode?
    var lf5 : SKSpriteNode?
    var oplf5 : SKSpriteNode?
    var rf5 : SKSpriteNode?
    var oprf5 : SKSpriteNode?
    var ball5 : SKSpriteNode?
    var spTitle, scTitle : SKLabelNode?
    var savePlays, savecf : SKSpriteNode?
    var ref : DatabaseReference?
    var storage : StorageReference?
    var selectForm = ""
    var user : User?
    var isPlayer : Bool?
    
    // formations
    // 2-2
    var rcb22 = SKAction.move(to: CGPoint(x: 410.982, y: 169.231), duration: 1)
    var lcb22 = SKAction.move(to: CGPoint(x: 403.584, y: -144.553), duration: 1)
    var lf22 = SKAction.move(to: CGPoint(x: 179.717, y: -97.518), duration: 1)
    var rf22 = SKAction.move(to: CGPoint(x: 179.717, y: 152.063), duration: 1)
    
    //3-1
    var rcb31 = SKAction.move(to: CGPoint(x: 403.584, y: 201.995), duration: 1)
    var lcb31 = SKAction.move(to: CGPoint(x: 403.584, y: -168.763), duration: 1)
    var lf31 = SKAction.move(to: CGPoint(x: 171.032, y: 5.447), duration: 1)
    var rf31 = SKAction.move(to: CGPoint(x: 370.992, y: 5.447), duration: 1)
    
    //1-3
    var rcb13 = SKAction.move(to: CGPoint(x: 171.032, y: 208.134), duration: 1)
    var lcb13 = SKAction.move(to: CGPoint(x: 171.032, y: -199.377), duration: 1)
    var lf13 = SKAction.move(to: CGPoint(x: 171.032, y: 5.447), duration: 1)
    var rf13 = SKAction.move(to: CGPoint(x: 370.922, y: 5.447), duration: 1)
    
    // 1-2-1
    var rf121 = SKAction.move(to: CGPoint(x: 370.922, y: 5.447), duration: 1)
    var rcb121 = SKAction.move(to: CGPoint(x: 241.531, y: 208.916), duration: 1)
    var lcb121 = SKAction.move(to: CGPoint(x: 241.531, y: -179.207), duration: 1)
    var lf121 = SKAction.move(to: CGPoint(x: 101.694, y: 5.447), duration: 1)
    
    //1-1-2
    var rf112 = SKAction.move(to: CGPoint(x: 370.922, y: 5.447), duration: 1)
    var rcb112 = SKAction.move(to: CGPoint(x: 208.71, y: 0.16), duration: 1)
    var lcb112 = SKAction.move(to: CGPoint(x: 70.922, y: -147.937), duration: 1)
    var lf112 = SKAction.move(to: CGPoint(x: 70.922, y: -152.063), duration: 1)
    
    public override func didMove(to view: SKView) {
        gk5 = childNode(withName: "gk5") as! SKSpriteNode!
        opGk5 = childNode(withName: "opgk5") as! SKSpriteNode!
        lcb5 = childNode(withName: "lcb5") as! SKSpriteNode!
        oplcb5 = childNode(withName: "oplcb5") as! SKSpriteNode!
        rcb5 = childNode(withName: "rcb5") as! SKSpriteNode!
        oprcb5 = childNode(withName: "oprcb5") as! SKSpriteNode!
        rf5 = childNode(withName: "rf5") as! SKSpriteNode!
        oprf5 = childNode(withName: "oprf5") as! SKSpriteNode!
        lf5 = childNode(withName: "lf5") as! SKSpriteNode!
        oplf5 = childNode(withName: "oplf5") as! SKSpriteNode!
        ball5 = childNode(withName: "ball5") as! SKSpriteNode!
        spTitle = childNode(withName: "saveplaylabel5") as! SKLabelNode!
        savePlays = childNode(withName: "saveplaybg5") as! SKSpriteNode!
        scTitle = childNode(withName: "savecflabel5") as! SKLabelNode!
        savecf = childNode(withName: "savecfbg5") as! SKSpriteNode!
        
        isPlayer = UserDefaults.standard.bool(forKey: "IamPlayer")
        
        spTitle?.isHidden = true
        savePlays?.isHidden = true
        scTitle?.isHidden = true
        savecf?.isHidden = true
        
        ref = Database.database().reference()
        storage = Storage.storage().reference()
        
        user = Auth.auth().currentUser
        if (user != nil){
            ref?.child("users").child((user?.uid)!).observeSingleEvent(of:.value, with: { (snapshot) in
                let val = snapshot.value as? NSDictionary
                let teamCode = val?["teamID"] as? String ?? ""
                self.ref?.child("teams").child(teamCode).observeSingleEvent(of: .value, with: { (snapshot) in
                    let val2 = snapshot.value as? NSDictionary
                    self.selectForm = val2?["selectedFormation"] as? String ?? ""
                    if (self.selectForm == "2-2"){
                        self.form22()
                    } else if (self.selectForm == "3-1") {
                        self.form31()
                    } else if (self.selectForm == "1-3"){
                        self.form13()
                    } else if (self.selectForm == "1-2-1"){
                        self.form121()
                    } else if (self.selectForm == "1-1-2"){
                        self.form112()
                    }

                })
            })
        }
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (!isPlayer!){
        spTitle?.isHidden = false
        savePlays?.isHidden = false
        scTitle?.isHidden = false
        savecf?.isHidden = false
        }
        for t in touches{
            let loc = t.location(in: self)
            if (savePlays?.contains(loc))!{
                saveSetPlay()
            }
            if (savecf?.contains(loc))!{
                SaveCustomFormation(alertMessage: "Save Custom Formation")
            }
        }

    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) { // moves players and ball
        

        for touch in touches{
            let tl = touch.location(in: self)
            if let node = self.atPoint(tl) as? SKSpriteNode{
                if (node.name == "gk5"){
                    gk5?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == "opgk5"){
                    opGk5?.position = CGPoint(x: tl.x, y: tl.y)
                }else if (node.name == "lcb5"){
                    lcb5?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == "oplcb5"){
                    oplcb5?.position = CGPoint(x: tl.x, y: tl.y)
                }else if (node.name == "rcb5"){
                    rcb5?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == "oprcb5"){
                    oprcb5?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == "rf5"){
                    rf5?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == "oprf5"){
                    oprf5?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == "lf5"){
                    lf5?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == "oplf5"){
                    oplf5?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == "ball5"){
                    ball5?.position = CGPoint(x: tl.x, y: tl.y)
                } 
            }
        }
    }
    
    func form22(){
        lcb5?.run(lcb22)
        rcb5?.run(rcb22)
        lf5?.run(lf22)
        rf5?.run(rf22)
    }
    
    func form31(){
        lcb5?.run(lcb31)
        rcb5?.run(rcb31)
        lf5?.run(lf31)
        rf5?.run(rf31)
    }
    
    func form13(){
        lcb5?.run(lcb13)
        rcb5?.run(rcb13)
        rf5?.run(rf13)
        lf5?.run(lf13)
    }
    
    func form121(){
        lcb5?.run(lcb121)
        rcb5?.run(rcb121)
        lf5?.run(lf121)
        rf5?.run(rf121)
    }
    
    func form112(){
        lcb5?.run(lcb112)
        rcb5?.run(rcb112)
        rf5?.run(rf112)
        lf5?.run(lf112)
    }
    
    func saveSetPlay(){
        print("savesetplay")
        let scrShot = self.view?.takeScreenShot5()
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
                print("playnAME\(playName)")
                let sref = Storage.storage().reference().child(teamCode).child(ft).child("plays").child(playName!)
                if let uploadData = UIImagePNGRepresentation(image){
                   _ = sref.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                        if let err = error{
                            print("imageerror \(err)")
                            return
                        } else {
                            let url = metadata!.downloadURL()
                        self.ref?.child("teams").child(teamCode).child("plays").child(ft).child(playName!).setValue(url?.absoluteString)
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
                print("cf\(fName)")
            self.ref?.child("teams").child(teamCode).child("customFormations").child(ft).child(fName!).child("title").setValue(fName!)
            self.ref?.child("teams").child(teamCode).child("customFormations").child(ft).child(fName!).child((self.lcb5?.name)!).child("x").setValue(self.lcb5?.position.x)
            self.ref?.child("teams").child(teamCode).child("customFormations").child(ft).child(fName!).child((self.lcb5?.name)!).child("y").setValue(self.lcb5?.position.y)
            self.ref?.child("teams").child(teamCode).child("customFormations").child(ft).child(fName!).child((self.rcb5?.name)!).child("x").setValue(self.rcb5?.position.x)
            self.ref?.child("teams").child(teamCode).child("customFormations").child(ft).child(fName!).child((self.rcb5?.name)!).child("y").setValue(self.rcb5?.position.y)
                self.ref?.child("teams").child(teamCode).child("customFormations").child(ft).child(fName!).child((self.lf5?.name)!).child("x").setValue(self.lf5?.position.x)
                self.ref?.child("teams").child(teamCode).child("customFormations").child(ft).child(fName!).child((self.lf5?.name)!).child("y").setValue(self.lf5?.position.y)
                self.ref?.child("teams").child(teamCode).child("customFormations").child(ft).child(fName!).child((self.rf5?.name)!).child("x").setValue(self.rf5?.position.x)
                self.ref?.child("teams").child(teamCode).child("customFormations").child(ft).child(fName!).child((self.rf5?.name)!).child("y").setValue(self.rf5?.position.y)
            })
            
        }))
        //self.view?.window.present(alert, animated: true, completion: nil)
        self.view?.window?.rootViewController?.present(alert, animated: true, completion: nil)
    }

    
}
extension UIView{
    
    func takeScreenShot5 () -> UIImage{
        print("take screen shot")
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
        
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
        
    }
    
}
