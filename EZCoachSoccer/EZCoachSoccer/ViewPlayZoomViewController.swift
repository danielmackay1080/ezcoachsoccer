//
//  ViewPlayZoomViewController.swift
//  EZCoachSoccer
//
//  Created by Daniel Mackay on 6/8/17.
//  Copyright © 2017 Daniel Mackay. All rights reserved.
//

import UIKit
import Firebase

class ViewPlayZoomViewController: ViewController {
    @IBOutlet weak var zoomPlay: UIImageView!

    @IBOutlet weak var delButton: UIButton!
    
    var isplayer = UserDefaults.standard.bool(forKey: "IamPlayer")
    var bigPlay : UIImage?
    var url : String?
    var playTitle : String?
    var ref : DatabaseReference?
    var storage : StorageReference?
    var user : User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        user = Auth.auth().currentUser
        if (isplayer){
            delButton.isHidden = true
        }
        zoomPlay.image = bigPlay

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func deletePlay(_ sender: Any) {
        ref?.child("users").child((user?.uid)!).observeSingleEvent(of:.value, with: { (snapshot) in
            let val = snapshot.value as? NSDictionary
            let teamCode = val?["teamID"] as? String ?? ""
            self.ref?.child("teams").child(teamCode).observeSingleEvent(of:.value, with: { (snapshot) in
                let ft = val?["fieldType"] as? String ?? ""
                self.ref?.child("teams").child(teamCode).child("plays").child(ft).child(self.playTitle!).removeValue()
                self.storage = Storage.storage().reference(forURL: self.url!)
                self.storage?.delete(completion: { (error) in
                    if let error = error{
                        print("deleteplays error \(error)")
                    } else {
                        self.navigationController?.popViewController(animated: true)
                        //self.navigationController.
                    }
                })

                })
            
        })

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
