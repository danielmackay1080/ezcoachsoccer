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
    
    var ref : FIRDatabaseReference?
    var uDef = UserDefaults.standard
    var isPlayer : Bool?
    var fieldType = ""
    var uid = FIRAuth.auth()?.currentUser?.uid
    var ft = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        ref = FIRDatabase.database().reference()
        ref?.child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
            let val = snapshot.value as? NSDictionary
            print("val \(val)")
            self.ft = val?["fieldType"] as? String ?? ""
            print("ft \(self.ft)")
            
            if (self.ft == "5v5"){
                let scn = FiveVFiveInterface(fileNamed: "FiveVFiveInterface")!
                let v = self.view as! SKView
                v.showsFPS = true
                v.showsNodeCount = true
                v.ignoresSiblingOrder = true
                scn.scaleMode = .aspectFit
                //scn.size = self.view.frame.size
                v.presentScene(scn)
                
            } else if (self.ft == "7v7"){
                let scn = SevenVSevenInterface(fileNamed: "SevenVSevenInterface")!
                let v = self.view as! SKView
                v.showsFPS = true
                v.showsNodeCount = true
                v.ignoresSiblingOrder = true
                scn.scaleMode = .aspectFit
                //scn.size = self.view.frame.size
                v.presentScene(scn)
                
                
            }else if (self.ft == "9v9"){
                let scn = NineVNineInterface(fileNamed: "NineVNineInterface")!
                let v = self.view as! SKView
                v.showsFPS = true
                v.showsNodeCount = true
                v.ignoresSiblingOrder = true
                scn.scaleMode = .aspectFit
                //scn.size = self.view.frame.size
                v.presentScene(scn)
                
                
            } else if (self.ft == "11v11"){
                let scn = ElevenVElevenInterface(fileNamed: "ElevenVElevenInterface")!
                let v = self.view as! SKView
                v.showsFPS = true
                v.showsNodeCount = true
                v.ignoresSiblingOrder = true
                scn.scaleMode = .aspectFit
                //scn.size = self.view.frame.size
                v.presentScene(scn)
                
                
            }

            
        })
        { (error) in
            print(error.localizedDescription)
        }
         print("ft \(ft)")
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
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
