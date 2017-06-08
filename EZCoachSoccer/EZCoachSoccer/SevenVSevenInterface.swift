//
//  SevenVSevenInterface.swift
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

public class SevenVSevenInterface : SKScene{
    
    var gk7 : SKSpriteNode?
    var lcb7 : SKSpriteNode?
    var rcb7 : SKSpriteNode?
    var cm7 : SKSpriteNode?
    var rm7 : SKSpriteNode?
    var lm7 : SKSpriteNode?
    var str7 : SKSpriteNode?
    
    var opgk7 : SKSpriteNode?
    var oplcb7 : SKSpriteNode?
    var oprcb7 : SKSpriteNode?
    var opcm7 : SKSpriteNode?
    var oplm7: SKSpriteNode?
    var oprm7 : SKSpriteNode?
    var opstr7: SKSpriteNode?
    var spTitle, scTitle : SKLabelNode?
    var savePlays,savecf : SKSpriteNode?
    
    var ball7 : SKSpriteNode?
    var ref : DatabaseReference?
    var selectForm = ""
    var user : User?
    var isPlayer : Bool?
    
    // formations
    // 3-3
    var lcb33 = SKAction.move(to: CGPoint(x: 449.765, y: -233.665), duration: 1)
    var rcb33 = SKAction.move(to: CGPoint(x: 449.765, y: 217.601), duration: 1)
    var cm33 = SKAction.move(to: CGPoint(x: 412.012, y: -2.845), duration: 1)
    var rm33 = SKAction.move(to: CGPoint(x: 194.924, y: 217.601), duration: 1)
    var lm33 = SKAction.move(to: CGPoint(x: 194.924, y: -233.665), duration: 1)
    var st33 = SKAction.move(to: CGPoint(x: 91.331, y: -2.845), duration: 1)
    
    //3-1-2
    var lcb312 = SKAction.move(to: CGPoint(x: 449.765, y: -233.665), duration: 1)
    var rcb312 = SKAction.move(to: CGPoint(x: 449.765, y: 217.601), duration: 1)
    var cm312 = SKAction.move(to: CGPoint(x: 412.012, y: -2.845), duration: 1)
    var rm312 = SKAction.move(to: CGPoint(x: 103.939, y: 127.155), duration: 1)
    var st312 = SKAction.move(to: CGPoint(x: 103.939, y: -119.71), duration: 1)
    var lm312 = SKAction.move(to: CGPoint(x: 250.425, y: -2.845), duration: 1)
    
    // 2-3-1
    var lcb231 = SKAction.move(to: CGPoint(x: 449.765, y: -148.734), duration: 1)
    var rcb231 = SKAction.move(to: CGPoint(x: 449.765, y: 153.196), duration: 1)
    var cm231 = SKAction.move(to: CGPoint(x: 294.788, y: -2.845), duration: 1)
    var rm231 = SKAction.move(to: CGPoint(x: 250.425, y: 227.747), duration: 1)
    var lm231 = SKAction.move(to: CGPoint(x: 250.425, y: -262.845), duration: 1)
    var st231 = SKAction.move(to: CGPoint(x: 120.425, y: -2.845), duration: 1)
    
    //2-1-2-1
    var lcb2121 = SKAction.move(to: CGPoint(x: 449.765, y: -148.734), duration: 1)
    var rcb2121 = SKAction.move(to: CGPoint(x: 449.765, y: 153.196), duration: 1)
    var cm2121 = SKAction.move(to: CGPoint(x: 345.146, y: -1.204), duration: 1)
    var rm2121 = SKAction.move(to: CGPoint(x: 197.707, y: 177.751), duration: 1)
    var lm2121 = SKAction.move(to: CGPoint(x: 197.707, y: -184.983), duration: 1)
    var st2121 = SKAction.move(to: CGPoint(x: 90.785, y: -1.204), duration: 1)
    
    //1-3-2
    var lcb132 = SKAction.move(to: CGPoint(x: 439.309, y: -2.845), duration: 1)
    var rcb132 = SKAction.move(to: CGPoint(x: 288.969, y: 227.747), duration: 1)
    var cm132 = SKAction.move(to: CGPoint(x: 288.969, y: -2.845), duration: 1)
    var lm132 = SKAction.move(to: CGPoint(x: 288.969, y: -248.852), duration: 1)
    var rm132 = SKAction.move(to: CGPoint(x:90.785, y: 128.796), duration: 1)
    var st132 = SKAction.move(to: CGPoint(x: 105.568, y: -118.852), duration: 1)
    
    
    
    
    public override func didMove(to view: SKView) {
        
        gk7 = childNode(withName: "gk7") as? SKSpriteNode!
        lcb7 = childNode(withName: "lcb7") as? SKSpriteNode!
        rcb7 = childNode(withName: "rcb7") as? SKSpriteNode!
        cm7 = childNode(withName: "cm7") as? SKSpriteNode!
        rm7 = childNode(withName: "rm7") as? SKSpriteNode!
        lm7 = childNode(withName: "lm7") as? SKSpriteNode!
        str7 = childNode(withName: "str7") as? SKSpriteNode!
        
        opgk7 = childNode(withName: "opgk7") as? SKSpriteNode!
        oplcb7 = childNode(withName: "oplcb7") as? SKSpriteNode!
        oprcb7 = childNode(withName: "oprcb7") as? SKSpriteNode!
        opcm7 = childNode(withName: "opcm7") as? SKSpriteNode!
        oplm7 = childNode(withName: "oplm7") as? SKSpriteNode!
        oprm7 = childNode(withName: "oprm7") as? SKSpriteNode!
        opstr7 = childNode(withName: "opstr7") as? SKSpriteNode!
        savePlays = childNode(withName: "saveplaybg7") as! SKSpriteNode!
        spTitle = childNode(withName: "saveplaylabel7") as! SKLabelNode!
        scTitle = childNode(withName: "savecflabel7") as! SKLabelNode!
        savecf = childNode(withName: "savecfbg7") as! SKSpriteNode!
        savePlays?.isHidden = true
        spTitle?.isHidden = true
        scTitle?.isHidden = true
        savecf?.isHidden = true
        
        ball7 = childNode(withName: "ball7") as? SKSpriteNode!
        
        isPlayer = UserDefaults.standard.bool(forKey: "IamPlayer")
        
        ref = Database.database().reference()
        user = Auth.auth().currentUser
        if (user != nil){
            ref?.child("users").child((user?.uid)!).observeSingleEvent(of:.value, with: { (snapshot) in
                let val = snapshot.value as? NSDictionary
                let teamCode = val?["teamID"] as? String ?? ""
                self.ref?.child("teams").child(teamCode).observeSingleEvent(of: .value, with: { (snapshot) in
                    let val2 = snapshot.value as? NSDictionary
                    let ft = val2?["fieldType"] as? String ?? ""
                    self.selectForm = val2?["selectedFormation"] as? String ?? ""
                    if (!self.selectForm.isEmpty){
                    if (self.selectForm == "3-3"){
                        self.form33()
                    } else if (self.selectForm == "3-1-2") {
                        self.form312()
                    } else if (self.selectForm == "2-3-1"){
                        self.form231()
                    } else if (self.selectForm == "2-1-2-1"){
                        self.form2121()
                    } else if (self.selectForm == "1-3-2"){
                        self.form132()
                    }else if (snapshot.childSnapshot(forPath: "customFormations").exists()){
                        if (snapshot.childSnapshot(forPath: ft).childSnapshot(forPath:(self.selectForm)).exists()){
                        let lcbx = snapshot.childSnapshot(forPath:"customFormations").childSnapshot(forPath: ft).childSnapshot(forPath: self.selectForm).childSnapshot(forPath: (self.lcb7?.name)!).childSnapshot(forPath: "x") .value as! CGFloat
                        let lcby = snapshot.childSnapshot(forPath:"customFormations").childSnapshot(forPath: ft).childSnapshot(forPath: self.selectForm).childSnapshot(forPath: (self.lcb7?.name)!).childSnapshot(forPath: "y") .value as! CGFloat
                        let rcbx = snapshot.childSnapshot(forPath:"customFormations").childSnapshot(forPath: ft).childSnapshot(forPath: self.selectForm).childSnapshot(forPath: (self.rcb7?.name)!).childSnapshot(forPath: "x") .value as! CGFloat
                        let rcby = snapshot.childSnapshot(forPath:"customFormations").childSnapshot(forPath: ft).childSnapshot(forPath: self.selectForm).childSnapshot(forPath: (self.rcb7?.name)!).childSnapshot(forPath: "y") .value as! CGFloat
                        let lfx = snapshot.childSnapshot(forPath:"customFormations").childSnapshot(forPath: ft).childSnapshot(forPath: self.selectForm).childSnapshot(forPath: (self.lm7?.name)!).childSnapshot(forPath: "x") .value as! CGFloat
                        let lfy = snapshot.childSnapshot(forPath:"customFormations").childSnapshot(forPath: ft).childSnapshot(forPath: self.selectForm).childSnapshot(forPath: (self.lm7?.name)!).childSnapshot(forPath: "y") .value as! CGFloat
                        let rfx = snapshot.childSnapshot(forPath:"customFormations").childSnapshot(forPath: ft).childSnapshot(forPath: self.selectForm).childSnapshot(forPath: (self.rm7?.name)!).childSnapshot(forPath: "x") .value as! CGFloat
                        let rfy = snapshot.childSnapshot(forPath:"customFormations").childSnapshot(forPath: ft).childSnapshot(forPath: self.selectForm).childSnapshot(forPath: (self.rm7?.name)!).childSnapshot(forPath: "y") .value as! CGFloat
                        let cmx = snapshot.childSnapshot(forPath:"customFormations").childSnapshot(forPath: ft).childSnapshot(forPath: self.selectForm).childSnapshot(forPath: (self.cm7?.name)!).childSnapshot(forPath: "x") .value as! CGFloat
                        let cmy = snapshot.childSnapshot(forPath:"customFormations").childSnapshot(forPath: ft).childSnapshot(forPath: self.selectForm).childSnapshot(forPath: (self.cm7?.name)!).childSnapshot(forPath: "y") .value as! CGFloat
                        let strx = snapshot.childSnapshot(forPath:"customFormations").childSnapshot(forPath: ft).childSnapshot(forPath: self.selectForm).childSnapshot(forPath: (self.str7?.name)!).childSnapshot(forPath: "x") .value as! CGFloat
                        let stry = snapshot.childSnapshot(forPath:"customFormations").childSnapshot(forPath: ft).childSnapshot(forPath: self.selectForm).childSnapshot(forPath: (self.str7?.name)!).childSnapshot(forPath: "y") .value as! CGFloat
                        
                        print("lcbx \(lcbx)")
                        
                        self.lcb7?.run(SKAction.move(to: CGPoint(x: lcbx, y: lcby), duration: 0.5))
                        self.rcb7?.run(SKAction.move(to: CGPoint(x: rcbx, y: rcby), duration: 0.5))
                        self.rm7?.run(SKAction.move(to: CGPoint(x: rfx, y: rfy), duration: 0.5))
                        self.lm7?.run(SKAction.move(to: CGPoint(x: lfx, y: lfy), duration: 0.5))
                        self.cm7?.run(SKAction.move(to: CGPoint(x: cmx, y: cmy), duration: 0.5))
                        self.str7?.run(SKAction.move(to: CGPoint(x: strx, y: stry), duration: 0.5))
                        
                    }

                    }
                    }
                })
            })
        }

    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (!isPlayer!){
            savePlays?.isHidden = false
            spTitle?.isHidden = false
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
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let tl = touch.location(in: self)
            if let node = self.atPoint(tl) as? SKSpriteNode{
                if (node.name == "ball7"){
                    ball7?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == "gk7"){
                    gk7?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == "lcb7"){
                    lcb7?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == "rcb7"){
                    rcb7?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == "cm7"){
                    cm7?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == "lm7"){
                    lm7?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == "rm7"){
                    rm7?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == "str7"){
                    str7?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == "opgk7"){
                    opgk7?.position = CGPoint(x: tl.x, y: tl.y)
                }else if (node.name == "oplcb7"){
                    oplcb7?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == "oprcb7"){
                    oprcb7?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == "opcm7"){
                    opcm7?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == "oplm7"){
                    oplm7?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == "oprm7"){
                    oprm7?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == "opstr7"){
                    opstr7?.position = CGPoint(x: tl.x, y: tl.y)
                }
            }
        }
    }
    
    func form33(){
        lcb7?.run(lcb33)
        rcb7?.run(rcb33)
        rm7?.run(rm33)
        lm7?.run(lm33)
        cm7?.run(cm33)
        str7?.run(st33)
    }
    
    func form312(){
        lcb7?.run(lcb312)
        rcb7?.run(rcb312)
        rm7?.run(rm312)
        lm7?.run(lm312)
        cm7?.run(cm312)
        str7?.run(st312)
    }
    
    func form231(){
        lcb7?.run(lcb231)
        rcb7?.run(rcb231)
        cm7?.run(cm231)
        lm7?.run(lm231)
        rm7?.run(rm231)
        str7?.run(st231)
    }
    
    func form2121(){
        lcb7?.run(lcb2121)
        rcb7?.run(rcb2121)
        cm7?.run(cm2121)
        lm7?.run(lm2121)
        rm7?.run(rm2121)
        str7?.run(st2121)
    }
    
    func form132(){
        lcb7?.run(lcb132)
        rcb7?.run(rcb132)
        cm7?.run(cm132)
        lm7?.run(lm132)
        rm7?.run(rm132)
        str7?.run(st132)
    }
    
    func saveSetPlay(){
        print("savesetplay")
        let scrShot = self.view?.takeScreenShot7()
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
                self.ref?.child("teams").child(teamCode).child("customFormations").child(ft).child(fName!).child((self.lcb7?.name)!).child("x").setValue(self.lcb7?.position.x)
                self.ref?.child("teams").child(teamCode).child("customFormations").child(ft).child(fName!).child((self.lcb7?.name)!).child("y").setValue(self.lcb7?.position.y)
                self.ref?.child("teams").child(teamCode).child("customFormations").child(ft).child(fName!).child((self.rcb7?.name)!).child("x").setValue(self.rcb7?.position.x)
                self.ref?.child("teams").child(teamCode).child("customFormations").child(ft).child(fName!).child((self.rcb7?.name)!).child("y").setValue(self.rcb7?.position.y)
                self.ref?.child("teams").child(teamCode).child("customFormations").child(ft).child(fName!).child((self.cm7?.name)!).child("x").setValue(self.cm7?.position.x)
                self.ref?.child("teams").child(teamCode).child("customFormations").child(ft).child(fName!).child((self.cm7?.name)!).child("y").setValue(self.cm7?.position.y)
                self.ref?.child("teams").child(teamCode).child("customFormations").child(ft).child(fName!).child((self.rm7?.name)!).child("x").setValue(self.rm7?.position.x)
                self.ref?.child("teams").child(teamCode).child("customFormations").child(ft).child(fName!).child((self.rm7?.name)!).child("y").setValue(self.rm7?.position.y)
                self.ref?.child("teams").child(teamCode).child("customFormations").child(ft).child(fName!).child((self.lm7?.name)!).child("x").setValue(self.lm7?.position.x)
                self.ref?.child("teams").child(teamCode).child("customFormations").child(ft).child(fName!).child((self.lm7?.name)!).child("y").setValue(self.lm7?.position.y)
                self.ref?.child("teams").child(teamCode).child("customFormations").child(ft).child(fName!).child((self.str7?.name)!).child("x").setValue(self.str7?.position.x)
                self.ref?.child("teams").child(teamCode).child("customFormations").child(ft).child(fName!).child((self.str7?.name)!).child("y").setValue(self.str7?.position.y)
                
                            })
            
        }))
        //self.view?.window.present(alert, animated: true, completion: nil)
        self.view?.window?.rootViewController?.present(alert, animated: true, completion: nil)
    }


    
}
extension UIView{
    
    func takeScreenShot7 () -> UIImage{
        print("take screen shot")
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
        
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
        
    }
    
}

