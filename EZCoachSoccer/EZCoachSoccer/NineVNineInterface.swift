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
    var spTitle, scTitle, gkkn, cbkn, lcbkn, rcbkn, lcmkn, rcmkn, rfkn, lfkn, stkn : SKLabelNode?
    
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
    var players = [Players]()
    
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
        gkkn = childNode(withName: "gkkn9") as! SKLabelNode!
        cbkn = childNode(withName: "cbkn9") as! SKLabelNode!
        rcbkn = childNode(withName: "rcbkn9") as! SKLabelNode!
        lcbkn = childNode(withName: "lcbkn9") as! SKLabelNode!
        lcmkn = childNode(withName: "lcmkn9") as! SKLabelNode!
        rcmkn = childNode(withName: "rcmkn9") as! SKLabelNode!
        lfkn = childNode(withName: "lfkn9") as! SKLabelNode!
        rfkn = childNode(withName: "rfkn9") as! SKLabelNode!
        stkn = childNode(withName: "stkn9") as! SKLabelNode!
        /*gk9?.addChild(gkkn!)
        cb9?.addChild(cbkn!)
        lcb9?.addChild(lcbkn!)
        rcb9?.addChild(rcbkn!)
        lcm9?.addChild(lcmkn!)
        rcm9?.addChild(rcmkn!)
        lf9?.addChild(lfkn!)
        rf9?.addChild(rfkn!)
        str9?.addChild(stkn!)
        gkkn?.verticalAlignmentMode = .center
        gkkn?.horizontalAlignmentMode = .center
        cbkn?.horizontalAlignmentMode = .center
        cbkn?.verticalAlignmentMode = .center
        lcbkn?.horizontalAlignmentMode = .center
        lcbkn?.verticalAlignmentMode = .center
        rcbkn?.horizontalAlignmentMode = .center
        rcbkn?.verticalAlignmentMode = .center
        lcmkn?.horizontalAlignmentMode = .center
        lcmkn?.verticalAlignmentMode = .center
        rcmkn?.horizontalAlignmentMode = .center
        rcmkn?.verticalAlignmentMode = .center
        lfkn?.horizontalAlignmentMode = .center
        lfkn?.verticalAlignmentMode = .center
        rfkn?.horizontalAlignmentMode = .center
        rfkn?.verticalAlignmentMode = .center
        stkn?.horizontalAlignmentMode = .center
        stkn?.verticalAlignmentMode = .center*/
        
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
                    let ft = val2?["fieldType"] as? String ?? ""
                    if (!self.selectForm.isEmpty){
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
                    } else if (snapshot.childSnapshot(forPath: "customFormations").exists()){
                        if(snapshot.childSnapshot(forPath:"customFormations").childSnapshot(forPath: ft).childSnapshot(forPath: (self.selectForm)).exists()){
                        let lcbx = snapshot.childSnapshot(forPath:"customFormations").childSnapshot(forPath: ft).childSnapshot(forPath: self.selectForm).childSnapshot(forPath: (self.lcb9?.name)!).childSnapshot(forPath: "x") .value as! CGFloat
                        let lcby = snapshot.childSnapshot(forPath:"customFormations").childSnapshot(forPath: ft).childSnapshot(forPath: self.selectForm).childSnapshot(forPath: (self.lcb9?.name)!).childSnapshot(forPath: "y") .value as! CGFloat
                        let rcbx = snapshot.childSnapshot(forPath:"customFormations").childSnapshot(forPath: ft).childSnapshot(forPath: self.selectForm).childSnapshot(forPath: (self.rcb9?.name)!).childSnapshot(forPath: "x") .value as! CGFloat
                        let rcby = snapshot.childSnapshot(forPath:"customFormations").childSnapshot(forPath: ft).childSnapshot(forPath: self.selectForm).childSnapshot(forPath: (self.rcb9?.name)!).childSnapshot(forPath: "y") .value as! CGFloat
                        let lfx = snapshot.childSnapshot(forPath:"customFormations").childSnapshot(forPath: ft).childSnapshot(forPath: self.selectForm).childSnapshot(forPath: (self.lf9?.name)!).childSnapshot(forPath: "x") .value as! CGFloat
                        let lfy = snapshot.childSnapshot(forPath:"customFormations").childSnapshot(forPath: ft).childSnapshot(forPath: self.selectForm).childSnapshot(forPath: (self.lf9?.name)!).childSnapshot(forPath: "y") .value as! CGFloat
                        let rfx = snapshot.childSnapshot(forPath:"customFormations").childSnapshot(forPath: ft).childSnapshot(forPath: self.selectForm).childSnapshot(forPath: (self.rf9?.name)!).childSnapshot(forPath: "x") .value as! CGFloat
                        let rfy = snapshot.childSnapshot(forPath:"customFormations").childSnapshot(forPath: ft).childSnapshot(forPath: self.selectForm).childSnapshot(forPath: (self.rf9?.name)!).childSnapshot(forPath: "y") .value as! CGFloat
                        let cbx = snapshot.childSnapshot(forPath:"customFormations").childSnapshot(forPath: ft).childSnapshot(forPath: self.selectForm).childSnapshot(forPath: (self.cb9?.name)!).childSnapshot(forPath: "x") .value as! CGFloat
                        let cby = snapshot.childSnapshot(forPath:"customFormations").childSnapshot(forPath: ft).childSnapshot(forPath: self.selectForm).childSnapshot(forPath: (self.cb9?.name)!).childSnapshot(forPath: "y") .value as! CGFloat
                        let strx = snapshot.childSnapshot(forPath:"customFormations").childSnapshot(forPath: ft).childSnapshot(forPath: self.selectForm).childSnapshot(forPath: (self.str9?.name)!).childSnapshot(forPath: "x") .value as! CGFloat
                        let stry = snapshot.childSnapshot(forPath:"customFormations").childSnapshot(forPath: ft).childSnapshot(forPath: self.selectForm).childSnapshot(forPath: (self.str9?.name)!).childSnapshot(forPath: "y") .value as! CGFloat
                        let lcmx = snapshot.childSnapshot(forPath:"customFormations").childSnapshot(forPath: ft).childSnapshot(forPath: self.selectForm).childSnapshot(forPath: (self.lcm9?.name)!).childSnapshot(forPath: "x") .value as! CGFloat
                        let lcmy = snapshot.childSnapshot(forPath:"customFormations").childSnapshot(forPath: ft).childSnapshot(forPath: self.selectForm).childSnapshot(forPath: (self.lcm9?.name)!).childSnapshot(forPath: "y") .value as! CGFloat
                        let rcmx = snapshot.childSnapshot(forPath:"customFormations").childSnapshot(forPath: ft).childSnapshot(forPath: self.selectForm).childSnapshot(forPath: (self.rcm9?.name)!).childSnapshot(forPath: "x") .value as! CGFloat
                        let rcmy = snapshot.childSnapshot(forPath:"customFormations").childSnapshot(forPath: ft).childSnapshot(forPath: self.selectForm).childSnapshot(forPath: (self.rcm9?.name)!).childSnapshot(forPath: "y") .value as! CGFloat
                        
                        print("lcbx \(lcbx)")
                        
                        self.lcb9?.run(SKAction.move(to: CGPoint(x: lcbx, y: lcby), duration: 0.5))
                        self.rcb9?.run(SKAction.move(to: CGPoint(x: rcbx, y: rcby), duration: 0.5))
                        self.rf9?.run(SKAction.move(to: CGPoint(x: rfx, y: rfy), duration: 0.5))
                        self.lf9?.run(SKAction.move(to: CGPoint(x: lfx, y: lfy), duration: 0.5))
                        self.cb9?.run(SKAction.move(to: CGPoint(x: cbx, y: cby), duration: 0.5))
                        self.str9?.run(SKAction.move(to: CGPoint(x: strx, y: stry), duration: 0.5))
                        self.rcm9?.run(SKAction.move(to: CGPoint(x: rcmx, y: rcmy), duration: 0.5))
                        self.lcm9?.run(SKAction.move(to: CGPoint(x: lcmx, y: lcmy), duration: 0.5))
                            
                            self.lcbkn?.run(SKAction.move(to: CGPoint(x: lcbx, y: lcby), duration: 0.5))
                            self.rcbkn?.run(SKAction.move(to: CGPoint(x: rcbx, y: rcby), duration: 0.5))
                            self.rfkn?.run(SKAction.move(to: CGPoint(x: rfx, y: rfy), duration: 0.5))
                            self.lfkn?.run(SKAction.move(to: CGPoint(x: lfx, y: lfy), duration: 0.5))
                            self.cbkn?.run(SKAction.move(to: CGPoint(x: cbx, y: cby), duration: 0.5))
                            self.rcmkn?.run(SKAction.move(to: CGPoint(x: rcmx, y: rcmy), duration: 0.5))
                            self.lcmkn?.run(SKAction.move(to: CGPoint(x: lcmx, y: lcmy), duration: 0.5))
                            self.stkn?.run(SKAction.move(to: CGPoint(x: strx, y: stry), duration: 0.5))
                        }
                        }
                    }
                    self.ref?.child("teams").child(teamCode).child("startingLineUp").child(ft).observeSingleEvent(of: .value, with: { (snaps) in
                        print("starte snap \(snaps)")
                        for child in snaps.children {
                            let items = child as! DataSnapshot
                            print("kn item \(items)")
                            let plfn = items.childSnapshot(forPath: "playerFirstName").value!
                            let plln = items.childSnapshot(forPath: "playerLastName").value!
                            let kn = items.childSnapshot(forPath: "kitNumber").value!
                            let pn = items.childSnapshot(forPath: "phoneNumber").value!
                            let ps1 = items.childSnapshot(forPath: "position1").value!
                            let ps2 = items.childSnapshot(forPath: "position2").value!
                            let plem = items.childSnapshot(forPath: "playerEmail").value!
                            let parem = items.childSnapshot(forPath: "parentEmail").value!
                            let parn = items.childSnapshot(forPath: "parentName").value!
                            self.players.append(Players(pfName: plfn as! String, plName: plln as! String, pos1: ps1 as! String, pos2: ps2 as! String, parentEm: parem as! String, playerEm: plem as! String, parentFN: parn as! String, kitNum: kn as! String, phoneNum: pn as! String))
                        }
                        if (self.players.count == 9){

                        for pls in self.players{
                            print("players arr \(pls)")
                                                            if (pls.pos1 == "GK"){
                                    self.gkkn?.text = pls.kitNum
                                } else if (pls.pos1 == "LCB"  || pls.pos1 == "LB" || pls.pos1 == "LWB" || pls.pos1 == "CB"){
                                    self.lcbkn?.text = pls.kitNum
                                } else if (pls.pos1 == "RCB" || pls.pos1 == "RB" || pls.pos1 == "RWB" || pls.pos1 == "CB" ){
                                    self.rcbkn?.text = pls.kitNum
                                } else if (pls.pos1 == "LF" || pls.pos1 == "LM" || pls.pos1 == "LAM" || pls.pos1 == "LW" || pls.pos1 == "CF"){
                                    self.lfkn?.text = pls.kitNum
                                } else if (pls.pos1 == "RF" || pls.pos1 == "RM" || pls.pos1 == "RAM" || pls.pos1 == "RM" || pls.pos1 == "CF" || pls.pos1 == "ST"){
                                    self.rfkn?.text = pls.kitNum
                                }  else if (pls.pos1 == "LCM" || pls.pos1 == "CM" || pls.pos1 == "CAM"){
                                    self.lcmkn?.text = pls.pos1
                                } else if (pls.pos1 == "RCM" || pls.pos1 == "CM" || pls.pos1 == "CAM"){
                                    self.rcmkn?.text = pls.kitNum
                                } else if (pls.pos1 == "ST" || pls.pos1 == "CF" || pls.pos1 == "CAM"){
                                    self.stkn?.text = pls.kitNum
                                } else if (pls.pos1 == "CB" || pls.pos1 == "CDM" || pls.pos1 == "CM" || pls.pos1 == "CAM"){
                                    self.cbkn?.text = pls.kitNum
                                }
                            }
                        } else {
                            let alert = UIAlertController(title: "Alert", message: "You are supposed to have 5 players in your starting line up but you currently have \(self.players.count)", preferredStyle: UIAlertControllerStyle.alert)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                            self.view?.window?.rootViewController?.present(alert, animated: true, completion: nil)
                        }
                        
                        
                    })

                    
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
                    gkkn?.position = CGPoint(x: tl.x, y: tl.y)
                }else if (node.name == "lcb9"){
                    lcb9?.position = CGPoint(x: tl.x, y: tl.y)
                    lcbkn?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == "cb9"){
                    cb9?.position = CGPoint(x: tl.x, y: tl.y)
                    cbkn?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == "rcb9"){
                    rcb9?.position = CGPoint(x: tl.x, y: tl.y)
                    rcbkn?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == "lcm9"){
                    lcm9?.position = CGPoint(x: tl.x, y: tl.y)
                    lcmkn?.position = CGPoint(x: tl.x, y: tl.y)
                }else if (node.name == "rcm9"){
                    rcm9?.position = CGPoint(x: tl.x, y: tl.y)
                    rcmkn?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == "rf9"){
                    rf9?.position = CGPoint(x: tl.x, y: tl.y)
                    rfkn?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == "lf9"){
                    lf9?.position = CGPoint(x: tl.x, y: tl.y)
                    lfkn?.position = CGPoint(x: tl.x, y: tl.y)
                }else if(node.name == "str9"){
                    str9?.position = CGPoint(x: tl.x, y: tl.y)
                    stkn?.position = CGPoint(x: tl.x, y: tl.y)
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
        
        lcbkn?.run(lcb3131)
        rcbkn?.run(rcb3131)
        cbkn?.run(cb3131)
        rcmkn?.run(rcm3131)
        lcmkn?.run(lcm3131)
        rfkn?.run(rf3131)
        lfkn?.run(lf3131)
        stkn?.run(str3131)
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
        
        lcbkn?.run(lcb323)
        rcbkn?.run(rcb323)
        cbkn?.run(cb323)
        rcmkn?.run(rcm323)
        lcmkn?.run(lcm323)
        rfkn?.run(rf323)
        lfkn?.run(lf323)
        stkn?.run(str323)
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
        
        lcbkn?.run(lcb233)
        rcbkn?.run(rcb233)
        cbkn?.run(cb233)
        rcmkn?.run(rcm233)
        lcmkn?.run(lcm233)
        rfkn?.run(rf233)
        lfkn?.run(lf233)
        stkn?.run(str233)
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
        
        lcbkn?.run(lcb242)
        rcbkn?.run(rcb242)
        cbkn?.run(cb242)
        rcmkn?.run(RCM242)
        lcmkn?.run(lcm242)
        rfkn?.run(rf242)
        lfkn?.run(lf242)
        stkn?.run(str242)
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
        
        lcbkn?.run(lcb2222)
        rcbkn?.run(rcb2222)
        cbkn?.run(cb2222)
        rcmkn?.run(rcm2222)
        lcmkn?.run(lcm2222)
        rfkn?.run(rf2222)
        lfkn?.run(lf2222)
        stkn?.run(str2222)
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

