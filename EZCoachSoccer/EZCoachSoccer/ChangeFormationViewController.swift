//
//  ChangeFormationViewController.swift
//  EZCoachSoccer
//
//  Created by Daniel Mackay on 5/24/17.
//  Copyright © 2017 Daniel Mackay. All rights reserved.
//

import UIKit
import Firebase

class ChangeFormationViewController: ViewController, UITableViewDelegate, UITableViewDataSource {
    
    var arr = ["4-1-4-1" , "3-1-4-2"]
    
    
    @IBOutlet weak var form1: UIButton!

    @IBOutlet weak var form2: UIButton!
    
    @IBOutlet weak var form3: UIButton!
    
    @IBOutlet weak var form4: UIButton!
    
    @IBOutlet weak var form5: UIButton!
    
    @IBOutlet weak var cFormationTable: UITableView!
    var ref : DatabaseReference?
    var user : User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        user = Auth.auth().currentUser
        ref?.child("users").child((user?.uid)!).observeSingleEvent(of:.value, with: { (snapshot) in
            let val = snapshot.value as? NSDictionary
            let tid = val?["teamID"] as? String ?? ""
            self.ref?.child("teams").child(tid).observeSingleEvent(of:.value, with: {(snapshot) in
                let val2 = snapshot.value as? NSDictionary
                let ft = val2?["fieldType"] as? String ?? ""
                //DispatchQueue.main.async {
                    if (ft == "5v5"){ // loads field type depending on what was saved
                    self.form1.setImage(#imageLiteral(resourceName: "formation22_5"), for: .selected)
                    self.form1.setTitle("2-2", for: .normal)
                    self.form2.setImage(#imageLiteral(resourceName: "formation13_5"), for: .normal)
                    self.form2.setTitle("1-3", for: .normal)
                    self.form3.setImage(#imageLiteral(resourceName: "formation31_5"), for: .normal)
                    self.form3.setTitle("3-1", for: .normal)
                    self.form4.setImage(#imageLiteral(resourceName: "formation121_5"), for: .normal)
                    self.form4.setTitle("1-2-1", for: .normal)
                    self.form5.setImage(#imageLiteral(resourceName: "formation112_5"), for: .normal)
                    self.form5.setTitle("1-1-2", for: .normal)
                    } else if (ft == "7v7"){
                        self.form1.setImage(#imageLiteral(resourceName: "formation33_7"), for: .normal)
                        self.form1.setTitle("3-3", for: .normal)
                        self.form2.setImage(#imageLiteral(resourceName: "formation312_7"), for: .normal)
                        self.form2.setTitle("3-1-2", for: .normal)
                        self.form3.setImage(#imageLiteral(resourceName: "formation231_7"), for: .normal)
                        self.form3.setTitle("2-3-1", for: .normal)
                        self.form4.setImage(#imageLiteral(resourceName: "formation132_7"), for: .normal)
                        self.form4.setTitle("1-3-2", for: .normal)
                        self.form5.setImage(#imageLiteral(resourceName: "formation2121_7"), for: .normal)
                        self.form5.setTitle("2-1-2-1", for: .normal)
                    }else if (ft == "9v9"){
                        self.form1.setImage(#imageLiteral(resourceName: "formation233_9"), for: .normal)
                        self.form1.setTitle("2-3-3", for: .normal)
                        self.form2.setImage(#imageLiteral(resourceName: "formation242_9"), for: .normal)
                        self.form2.setTitle("2-4-2", for: .normal)
                        self.form3.setImage(#imageLiteral(resourceName: "formation2222_9"), for: .normal)
                        self.form3.setTitle("2-2-2-2", for: .normal)
                        self.form4.setImage(#imageLiteral(resourceName: "formation323_9"), for: .normal)
                        self.form4.setTitle("3-2-3", for: .normal)
                        self.form5.setImage(#imageLiteral(resourceName: "formation31211_9"), for: .normal)
                        self.form5.setTitle("3-1-2-1-1", for: .normal)
                    } else if (ft == "11v11"){
                        self.form1.setImage(#imageLiteral(resourceName: "formation442_11"), for: .normal)
                        self.form1.setTitle("4-4-2", for: .normal)
                        self.form2.setImage(#imageLiteral(resourceName: "formation433_11"), for: .normal)
                        self.form2.setTitle("4-3-3", for: .normal)
                        self.form3.setImage(#imageLiteral(resourceName: "formation4231_11"), for: .normal)
                        self.form3.setTitle("4-2-3-1", for: .normal)
                        self.form4.setImage(#imageLiteral(resourceName: "formation343_11"), for: .normal)
                        self.form4.setTitle("1-2-1", for: .normal)
                        self.form5.setImage(#imageLiteral(resourceName: "formation532_11"), for: .normal)
                        self.form5.setTitle("5-3-2", for: .normal)
                    }
 
                //}
            })
            
        })

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return arr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cformationcell") as! FormationTableViewCell
        cell.Ftitle.text = arr[indexPath.row]
        return cell
    }
    
    @IBAction func savef1(_ sender: Any) {
        saveLoadedFormation(title: form1.currentTitle!)
    }

    @IBAction func savef2(_ sender: Any) {
        saveLoadedFormation(title: form2.currentTitle!)
    }
    
    @IBAction func savef3(_ sender: Any) {
        saveLoadedFormation(title: form3.currentTitle!)
    }
    
    @IBAction func savef4(_ sender: Any) {
        saveLoadedFormation(title: form4.currentTitle!)
    }
    
    @IBAction func savef5(_ sender: Any) {
        saveLoadedFormation(title: form5.currentTitle!)
    }
    
    func saveLoadedFormation (title : String){
        ref?.child("users").child((user?.uid)!).observe(.value, with: { (snapshot) in
            let val = snapshot.value as? NSDictionary
            let tid = val?["teamID"] as? String ?? ""
            self.ref?.child("teams").child(tid).child("selectedFormation").setValue(title)
        })
            self.tabBarController?.selectedIndex = 1
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
