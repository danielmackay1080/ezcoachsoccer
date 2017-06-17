//
//  FieldViewController.swift
//  EZCoachSoccer
//
//  Created by Daniel Mackay on 5/18/17.
//  Copyright © 2017 Daniel Mackay. All rights reserved.
//

import UIKit
import Firebase
import GameplayKit
import SpriteKit

class FieldViewController: UIViewController {
    
    var ref : DatabaseReference?
    var uDef = UserDefaults.standard
    var isPlayer : Bool?
    var fieldType = ""
    var uid = Auth.auth().currentUser?.uid
    var ft = ""
    var tc = ""
    public static var scn : SKScene?
    public static var v : SKView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        presentScn()
        //self.navigationController?.navigationBar.isHidden = false;
        //self.tabBarController?.tabBarController.h
        // Do any additional setup after loading the view.
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        ref = Database.database().reference()
        presentScn()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func presentScn (){
        ref?.child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
            let val = snapshot.value as? NSDictionary
            // print("val \(val)")
            self.tc = val?["teamID"] as? String ?? ""
            self.ref?.child("teams").child(self.tc).observeSingleEvent(of:.value, with: {(snapshot) in
                let val = snapshot.value as? NSDictionary
                self.ft = val?["fieldType"] as? String ?? ""
                
                print("ft \(self.ft)")
                
                if (self.ft == "5v5"){ // loads field type depending on what was saved
                    FieldViewController.scn = FiveVFiveInterface(fileNamed: "FiveVFiveInterface")!
                    
                    
                    FieldViewController.v = self.view.viewWithTag(2) as? SKView
                    FieldViewController.v?.showsFPS = true
                    FieldViewController.v?.showsNodeCount = true
                    FieldViewController.v?.ignoresSiblingOrder = true
                    FieldViewController.scn?.scaleMode = .aspectFit
                    //scn.size = self.view.frame.size
                    FieldViewController.v?.presentScene(FieldViewController.scn)
                    
                } else if (self.ft == "7v7"){
                    FieldViewController.scn = SevenVSevenInterface(fileNamed: "SevenVSevenInterface")!
                    FieldViewController.v = self.view.viewWithTag(2) as? SKView
                    FieldViewController.v?.showsFPS = true
                    FieldViewController.v?.showsNodeCount = true
                    FieldViewController.v?.ignoresSiblingOrder = true
                    FieldViewController.scn?.scaleMode = .aspectFit
                    //scn.size = self.view.frame.size
                    FieldViewController.v?.presentScene(FieldViewController.scn)
                    
                    
                }else if (self.ft == "9v9"){
                    FieldViewController.scn = NineVNineInterface(fileNamed: "NineVNineInterface")!
                    FieldViewController.v = self.view.viewWithTag(2) as? SKView
                    FieldViewController.v?.showsFPS = true
                    FieldViewController.v?.showsNodeCount = true
                    FieldViewController.v?.ignoresSiblingOrder = true
                    FieldViewController.scn?.scaleMode = .aspectFit
                    //scn.size = self.view.frame.size
                    FieldViewController.v?.presentScene(FieldViewController.scn)
                    
                    
                } else if (self.ft == "11v11"){
                    FieldViewController.scn = ElevenVElevenInterface(fileNamed: "ElevenVElevenInterface")!
                    
                    FieldViewController.v = self.view.viewWithTag(2) as? SKView
                    //FieldViewController.v?.showsFPS = true
                    //FieldViewController.v?.showsNodeCount = true
                    FieldViewController.v?.ignoresSiblingOrder = true
                    FieldViewController.scn?.scaleMode = .fill
                    //scn.size = self.view.frame.size
                    FieldViewController.v?.presentScene(FieldViewController.scn)
                    
                    
                }
                
            })
            
            
        })
        { (error) in
            print("field error \(error.localizedDescription)")
        }
        //print("ft \(ft)")

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
