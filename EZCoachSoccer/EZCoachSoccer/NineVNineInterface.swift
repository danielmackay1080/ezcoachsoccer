//
//  NineVNineInterface.swift
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

public class NineVNineInterface : SKScene{
    
    var gk9, cb9, lcb9, rcb9, lcm9, rcm9, rf9, str9, lf9, ball9, savePlays, savecf : SKSpriteNode?
    var opgk9, opcb9, oplcb9, oprcb9, oplcm9, oprcm9, oprf9, opstr9, oplf9 : SKSpriteNode?
    var spTitle, scTitle : SKLabelNode?
    
    // formations
    // 3-2-3
    var rcb323 = SKAction.move(to: CGPoint(x: 437.816, y: 207.658), duration: 1)
    var cb323 = SKAction.move(to: CGPoint(x: 437.816, y: -203.873), duration: 1)
    var lcb323 = SKAction.move(to: CGPoint(x: 437.816, y: 7.967), duration: 1)
    var rcm323 = SKAction.move(to: CGPoint(x: 266.743, y: 99.369), duration: 1)
    var lcm323 = SKAction.move(to: CGPoint(x: 266.743, y: -88.873), duration: 1)
    var rf323 = SKAction.move(to: CGPoint(x: 103.689, y: 254.404), duration: 1)
    var str323 = SKAction.move(to: CGPoint(x: 103.689, y: -4.879), duration: 1)
    var lf323 = SKAction.move(to: CGPoint(x: 103.689, y: -262.008), duration: 1)
    
    //2-3-3
    var rf233 = SKAction.move(to: CGPoint(x: 103.689, y: 254.404), duration: 1)
    var str233 = SKAction.move(to: CGPoint(x: 103.689, y: -4.879), duration: 1)
    var lf233 = SKAction.move(to: CGPoint(x: 103.689, y: -262.008), duration: 1)
    var rcb233 = SKAction.move(to: CGPoint(x: 266.743, y: 178.35), duration: 1)
    var rcm233 = SKAction.move(to: CGPoint(x: 266.743, y: 0.467), duration: 1)
    var lcm233 = SKAction.move(to: CGPoint(x: 266.743, y: -196.373), duration: 1)
    var lcb233 = SKAction.move(to: CGPoint(x: 437.816, y: -107.033), duration: 1)
    var cb233 = SKAction.move(to: CGPoint(x: 437.816, y: 63.35), duration: 1)
    
    // 2-4-2
    var lcb242 = SKAction.move(to: CGPoint(x: 437.816, y: -107.033), duration: 1)
    var cb242 = SKAction.move(to: CGPoint(x: 437.816, y: 63.35), duration: 1)
    var rcb242 = SKAction.move(to: CGPoint(x: 266.743, y: 246.904), duration: 1)
    var RCM242 = SKAction.move(to: CGPoint(x: 266.743, y: 63.35), duration: 1)
    var lcm242 = SKAction.move(to: CGPoint(x: 266.743, y: -122.033), duration: 1)
    var lf242 = SKAction.move(to: CGPoint(x: 266.743, y: -297.942), duration: 1)
    var rf242 = SKAction.move(to: CGPoint(x: 103.689, y: 63.35), duration: 1)
    var str242 = SKAction.move(to: CGPoint(x: 103.689, y: -107.033), duration: 1)
    
    //2-2-2-2
    var rf2222 = SKAction.move(to: CGPoint(x: 103.689, y: 63.35), duration: 1)
    var str2222 = SKAction.move(to: CGPoint(x: 103.689, y: -107.033), duration: 1)
    var rcb2222 = SKAction.move(to: CGPoint(x: 200.003, y: 246.904), duration: 1)
    var lf2222 = SKAction.move(to: CGPoint(x: 200.003, y: -289.428), duration: 1)
    var lcb2222 = SKAction.move(to: CGPoint(x: 437.816, y: -147.008), duration: 1)
    var cb2222 = SKAction.move(to: CGPoint(x: 437.816, y: 100.158), duration: 1)
    var rcm2222 = SKAction.move(to: CGPoint(x: 292.907, y: 63.35), duration: 1)
    var lcm2222 = SKAction.move(to: CGPoint(x: 292.907, y: -93.929), duration: 1)
    
    // 3-1-3-1
    var rcb3131 = SKAction.move(to: CGPoint(x: 200.003, y: 200.158), duration: 1)
    var lcb3131 = SKAction.move(to: CGPoint(x: 437.816, y: -182.219), duration: 1)
    var cb3131 = SKAction.move(to: CGPoint(x: 437.816, y: 178.35), duration: 1)
    var lcm3131 = SKAction.move(to: CGPoint(x: 437.816, y: -7.033), duration: 1)
    var rcm3131 = SKAction.move(to: CGPoint(x: 322.816, y: -7.033), duration: 1)
    var rf3131 = SKAction.move(to: CGPoint(x: 200.003, y: -7.033), duration: 1)
    var str3131 = SKAction.move(to: CGPoint(x: 84.614, y: -7.033), duration: 1)
    var lf3131 = SKAction.move(to: CGPoint(x: 200.003, y: -234.247), duration: 1)
    
    var ref : DatabaseReference?
    var selectForm = ""
    var user : User?
    var isPlayer : Bool?
    
    public override func didMove(to view: SKView) {
        
        ball9 = childNode(withName: "ball9") as? SKSpriteNode!
        gk9 = childNode(withName: "gk9") as? SKSpriteNode!
        cb9 = childNode(withName: "cb9") as? SKSpriteNode!
        rcb9 = childNode(withName: "rcb9") as? SKSpriteNode!
        lcb9 = childNode(withName: "lcb9") as? SKSpriteNode!
        lcm9 = childNode(withName: "lcm9") as? SKSpriteNode!
        rcm9 = childNode(withName: "rcm9") as? SKSpriteNode!
        rf9 = childNode(withName: "rf9") as? SKSpriteNode!
        lf9 = childNode(withName: "lf9") as? SKSpriteNode!
        str9 = childNode(withName: "str9") as? SKSpriteNode!
        
        opgk9 = childNode(withName: "opgk9") as? SKSpriteNode!
        opcb9 = childNode(withName: "opcb9") as? SKSpriteNode!
        oplcb9 = childNode(withName: "oplcb9") as? SKSpriteNode!
        oprcb9 = childNode(withName: "oprcb9") as? SKSpriteNode!
        oplcm9 = childNode(withName: "oplcm9") as? SKSpriteNode!
        oprcm9 = childNode(withName: "oprcm9") as? SKSpriteNode!
        oprf9 = childNode(withName: "oprf9") as? SKSpriteNode!
        oplf9 = childNode(withName: "oplf9") as? SKSpriteNode!
        opstr9 = childNode(withName: "opstr9") as? SKSpriteNode!
        savePlays = childNode(withName: "saveplaybg9") as! SKSpriteNode!
        spTitle = childNode(withName: "saveplaylabel9") as! SKLabelNode!
        scTitle = childNode(withName: "savecflabel9") as! SKLabelNode!
        savecf = childNode(withName: "savecfbg9") as! SKSpriteNode!
        savecf?.isHidden = true
        scTitle?.isHidden = true
        savePlays?.isHidden = true
        spTitle?.isHidden = true
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
                    if (self.selectForm == "3-2-3"){
                        self.form323()
                    } else if (self.selectForm == "2-3-3") {
                        self.form233()
                    } else if (self.selectForm == "2-4-2"){
                        self.form242()
                    } else if (self.selectForm == "2-2-2-2"){
                        self.form2222()
                    } else if (self.selectForm == "3-1-2-1-1"){
                        self.form3131()
                    }
                    
                })
            })
        }

    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (!isPlayer!){
            spTitle?.isHidden = false
            savePlays?.isHidden = false
            savecf?.isHidden = false
            scTitle?.isHidden = false
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
                if (node.name == "ball9"){
                    ball9?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == "gk9"){
                    gk9?.position = CGPoint(x: tl.x, y: tl.y)
                }else if (node.name == "lcb9"){
                    lcb9?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == "cb9"){
                    cb9?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == "rcb9"){
                    rcb9?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == "lcm9"){
                    lcm9?.position = CGPoint(x: tl.x, y: tl.y)
                }else if (node.name == "rcm9"){
                    rcm9?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == "rf9"){
                    rf9?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == "lf9"){
                    lf9?.position = CGPoint(x: tl.x, y: tl.y)
                }else if(node.name == "str9"){
                    str9?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == "opgk9"){
                    opgk9?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == "oplcb9"){
                    oplcb9?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == "oprcb9"){
                    oprcb9?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == "opcb9"){
                    opcb9?.position = CGPoint(x: tl.x, y: tl.y)
                }else if (node.name == "oprcm9"){
                    oprcm9?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == "oplcm9"){
                    oplcm9?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == "opstr9"){
                    opstr9?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == "oplf9"){
                    oplf9?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == "oprf9"){
                    oprf9?.position = CGPoint(x: tl.x, y: tl.y)
                }
            }
        }
    }
    
    func form3131(){
        rcb9?.run(rcb3131)
        lcb9?.run(lcb3131)
        cb9?.run(cb3131)
        rcm9?.run(rcm3131)
        lcm9?.run(lcm3131)
        rf9?.run(rf3131)
        lf9?.run(lf3131)
        str9?.run(str3131)
    }
    
    func form323(){
        rcb9?.run(rcb323)
        lcb9?.run(lcb323)
        cb9?.run(cb323)
        rcm9?.run(rcm323)
        lcm9?.run(lcm323)
        rf9?.run(rf323)
        lf9?.run(lf323)
        str9?.run(str323)
    }
    
    func form233(){
        rcb9?.run(rcb233)
        lcb9?.run(lcb233)
        cb9?.run(cb233)
        rcm9?.run(rcm233)
        lcm9?.run(lcm233)
        rf9?.run(rf233)
        lf9?.run(lf233)
        str9?.run(str233)
    }
    
    func form242(){
        rcb9?.run(rcb242)
        lcb9?.run(lcb242)
        cb9?.run(cb242)
        rcm9?.run(RCM242)
        lcm9?.run(lcm242)
        rf9?.run(rf242)
        lf9?.run(lf242)
        str9?.run(str242)
    }
    
    func form2222(){
        rcb9?.run(rcb2222)
        lcb9?.run(lcb2222)
        cb9?.run(cb2222)
        rcm9?.run(rcm2222)
        lcm9?.run(lcm2222)
        rf9?.run(rf2222)
        lf9?.run(lf2222)
        str9?.run(str2222)
    }
    
    func saveSetPlay(){
        print("savesetplay")
        let scrShot = self.view?.takeScreenShot9()
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
                print("cf\(String(describing: fName))")
                self.ref?.child("teams").child(teamCode).child("customFormations").child(ft).child(fName!).child("title").setValue(fName!)
                self.ref?.child("teams").child(teamCode).child("customFormations").child(ft).child(fName!).child((self.lcb9?.name)!).child("x").setValue(self.lcb9?.position.x)
                self.ref?.child("teams").child(teamCode).child("customFormations").child(ft).child(fName!).child((self.lcb9?.name)!).child("y").setValue(self.lcb9?.position.y)
                self.ref?.child("teams").child(teamCode).child("customFormations").child(ft).child(fName!).child((self.rcb9?.name)!).child("x").setValue(self.rcb9?.position.x)
                self.ref?.child("teams").child(teamCode).child("customFormations").child(ft).child(fName!).child((self.rcb9?.name)!).child("y").setValue(self.rcb9?.position.y)
                self.ref?.child("teams").child(teamCode).child("customFormations").child(ft).child(fName!).child((self.cb9?.name)!).child("x").setValue(self.cb9?.position.x)
                self.ref?.child("teams").child(teamCode).child("customFormations").child(ft).child(fName!).child((self.cb9?.name)!).child("y").setValue(self.cb9?.position.y)
                self.ref?.child("teams").child(teamCode).child("customFormations").child(ft).child(fName!).child((self.lcm9?.name)!).child("x").setValue(self.lcm9?.position.x)
                self.ref?.child("teams").child(teamCode).child("customFormations").child(ft).child(fName!).child((self.lcm9?.name)!).child("y").setValue(self.lcm9?.position.y)
                self.ref?.child("teams").child(teamCode).child("customFormations").child(ft).child(fName!).child((self.rcm9?.name)!).child("x").setValue(self.rcm9?.position.x)
                self.ref?.child("teams").child(teamCode).child("customFormations").child(ft).child(fName!).child((self.rcm9?.name)!).child("y").setValue(self.rcm9?.position.y)
                self.ref?.child("teams").child(teamCode).child("customFormations").child(ft).child(fName!).child((self.lf9?.name)!).child("x").setValue(self.lf9?.position.x)
                self.ref?.child("teams").child(teamCode).child("customFormations").child(ft).child(fName!).child((self.lf9?.name)!).child("y").setValue(self.lf9?.position.y)
                self.ref?.child("teams").child(teamCode).child("customFormations").child(ft).child(fName!).child((self.rf9?.name)!).child("x").setValue(self.rf9?.position.x)
                self.ref?.child("teams").child(teamCode).child("customFormations").child(ft).child(fName!).child((self.rf9?.name)!).child("y").setValue(self.rf9?.position.y)
                self.ref?.child("teams").child(teamCode).child("customFormations").child(ft).child(fName!).child((self.str9?.name)!).child("x").setValue(self.str9?.position.x)
                self.ref?.child("teams").child(teamCode).child("customFormations").child(ft).child(fName!).child((self.str9?.name)!).child("y").setValue(self.str9?.position.y)
                
                
            })
            
        }))
        //self.view?.window.present(alert, animated: true, completion: nil)
        self.view?.window?.rootViewController?.present(alert, animated: true, completion: nil)
    }


    
}
extension UIView{
    
    func takeScreenShot9 () -> UIImage{
        print("take screen shot")
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
        
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
        
    }
    
}

