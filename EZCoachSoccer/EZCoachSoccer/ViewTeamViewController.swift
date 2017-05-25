//
//  ViewTeamViewController.swift
//  EZCoachSoccer
//
//  Created by Daniel Mackay on 5/18/17.
//  Copyright © 2017 Daniel Mackay. All rights reserved.
//

import UIKit
import Firebase

class ViewTeamViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var AddplayerButton: UIButton!
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var teamBadge: UIImageView!
    @IBOutlet weak var teamTable: UITableView!
    @IBOutlet weak var coachName: UILabel!
    var ref : DatabaseReference?
    var arrPlay  = [Players]()
    var tid = ""
    var isPlayer : Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        teamTable.delegate = self
        ref = Database.database().reference()
        isPlayer = UserDefaults.standard.bool(forKey: "IamPlayer")
        if (isPlayer)!{
            AddplayerButton.isHidden = true
        }
        // Do any additional setup after loading the view.
        ref?.child("users").child((Auth.auth().currentUser?.uid)!).observe(.value, with: { (snapshot) in // reads data for tableview
            let val = snapshot.value as? NSDictionary
            self.tid = val?["teamID"] as? String ?? ""
            self.coachName.text! = val?["coachName"] as? String ?? ""
            self.idLabel.text! = self.tid
            let ref2 = self.ref?.child("teams").child(self.tid).child("players")
            ref2?.observe(.value, with: { (snapshot) in
                _ = snapshot.value as? [NSDictionary]
                //print("val \(String(describing: val))")
                //self.arrPlay = val?["players"] as? [NSDictionary] ?? ["":""]
                if (self.arrPlay.count > 0){
                    self.arrPlay.removeAll()
                }
                for child in  snapshot.children{
                    let item = child as! DataSnapshot
                    //let dict = ((item as AnyObject) as AnyObject) as! NSDictionary
                    let plfn = item.childSnapshot(forPath: "playerFirstName").value!
                    let plln = item.childSnapshot(forPath: "playerLastName").value!
                    let kn = item.childSnapshot(forPath: "kitNumber").value!
                    let pn = item.childSnapshot(forPath: "phoneNumber").value!
                    let ps1 = item.childSnapshot(forPath: "position1").value!
                    let ps2 = item.childSnapshot(forPath: "position2").value!
                    let plem = item.childSnapshot(forPath: "playerEmail").value!
                    let parem = item.childSnapshot(forPath: "parentEmail").value!
                    let parn = item.childSnapshot(forPath: "parentName").value!
                    
                    
                //print("arrplay \(chi)")
                self.arrPlay.append(Players(pfName: plfn as! String, plName: plln as! String, pos1: ps1 as! String, pos2: ps2 as! String, parentEm: parem as! String, playerEm: plem as! String, parentFN: parn as! String, kitNum: kn as! String, phoneNum: pn as! String))
                print("arrplay \(self.arrPlay)")

                }
                self.teamTable.reloadData()
            })
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView,cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tcell") as! TeamCell
        cell.playerFullName.text = arrPlay[indexPath.row].pfName + " "+arrPlay[indexPath.row].plName
        cell.kitNumber.text = arrPlay[indexPath.row].kitNum
        cell.emailAddresses.text = arrPlay[indexPath.row].playerEm + " "+arrPlay[indexPath.row].parentEm
        cell.phoneNumber.text = arrPlay[indexPath.row].phoneNum
        cell.playerPositions.text = "Positions: "+arrPlay[indexPath.row].pos1+" "+arrPlay[indexPath.row].pos2
        cell.parentName.text = arrPlay[indexPath.row].parentFN
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrPlay.count
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
