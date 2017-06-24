//
//  ViewTeamViewController.swift
//  EZCoachSoccer
//
//  Created by Daniel Mackay on 5/18/17.
//  Copyright © 2017 Daniel Mackay. All rights reserved.
//

import UIKit
import Firebase
import ImagePicker
import DKImagePickerController

class ViewTeamViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var ftLabel: UILabel!
    
    @IBOutlet var teamLogo: UIButton!
    
    @IBOutlet weak var AddplayerButton: UIButton!
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var teamTable: UITableView!
    @IBOutlet weak var coachName: UILabel!
    var ref : DatabaseReference?
    var arrPlay  = [Players]()
    var lineup = [Players]()
    var tid = ""
    var isPlayer : Bool?
    var picker : UIImagePickerController?
    var udef = UserDefaults.standard
    var ft = ""
    var firstCall = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //shouldAutorotate = false
        teamTable.delegate = self
        ref = Database.database().reference()
        isPlayer = UserDefaults.standard.bool(forKey: "IamPlayer")
        //picker?.delegate = self
        //teamTable.minimumZoomScale
        if (isPlayer)!{
            AddplayerButton.isHidden = true
        }
        // Do any additional setup after loading the view.
        if (Auth.auth().currentUser != nil){
            ref?.child("users").child((Auth.auth().currentUser?.uid)!).observe(.value, with: { (snapshot) in // reads data for tableview
                let val = snapshot.value as? NSDictionary
                self.tid = val?["teamID"] as? String ?? ""
                //self.coachName.text! = val?["coachName"] as? String ?? ""
                self.idLabel.text! = "Team ID: \(self.tid)"
                self.ref?.observeSingleEvent(of: .value, with: { (snapshot1) in
                    if (snapshot1.childSnapshot(forPath: "teams").exists()){
                        _ = Storage.storage().reference().child(self.tid).child("teamCrest").child("teamCrest.png").getData(maxSize: 1*10000*10000, completion: { (data, error) in
                            if let error = error {
                                print("images loading error \(error)")
                            } else {
                                let im = UIImage(data: data!)
                                if (im  != nil){
                                    self.teamLogo.setImage(im, for: .normal)
                                }
                            }
                        })
                        
                        if (!self.tid.isEmpty){
                            _ = self.ref?.child("teams").child(self.tid).observe(.value, with: { (snapshot) in
                                if (snapshot.childSnapshot(forPath: "fieldType").exists()){
                                    let cn = snapshot.childSnapshot(forPath: "coachName").value
                                    self.ft = snapshot.childSnapshot(forPath: "fieldType").value as! String
                                    self.coachName.text = cn as? String
                                    self.ftLabel.text = "Field Type: \(self.ft )"
                                    self.tabBarController?.navigationItem.title = self.ft
                                }
                                
                                
                                if (snapshot.childSnapshot(forPath: "players").exists()){
                                    
                                    //storage.data
                                    let ref3 = self.ref?.child("teams").child(self.tid).child("players")
                                    ref3?.observe(.value, with: { (snapshot) in
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
                                        let ref4 = self.ref?.child("teams").child(self.tid).child("startingLineUp").child(self.ft)
                                        ref4?.observe(.value, with: { (snaps) in
                                            if (self.lineup.count > 0){
                                                self.lineup.removeAll()
                                            }
                                            if (snaps.exists()){
                                                for child in  snaps.children{
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
                                                    self.lineup.append(Players(pfName: plfn as! String, plName: plln as! String, pos1: ps1 as! String, pos2: ps2 as! String, parentEm: parem as! String, playerEm: plem as! String, parentFN: parn as! String, kitNum: kn as! String, phoneNum: pn as! String))
                                                    print("lineup \(self.lineup)")
                                                    
                                                }
                                            }
                                            self.teamTable.reloadData()
                                        })
                                        
                                        //self.teamTable.reloadData()
                                    })
                                }
                            })
                        }
                    }
                })
                
            })
            
        }
        if (isPlayer! || (Auth.auth().currentUser?.isAnonymous)!){
            teamTable.setEditing(false, animated: false)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //teamTable.setEditing(true, animated: true)
        //tableView.isEditing = true
        if (!isPlayer!){
            let alert = UIAlertController(title: "Alert", message: "Add or remove player from starting line up", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { (action) in
                self.ref?.child("users").child((Auth.auth().currentUser?.uid)!).observe(.value, with: { (snapshot) in // reads data for tableview
                    let val = snapshot.value as? NSDictionary
                    self.tid = val?["teamID"] as? String ?? ""
                    let playersDict = ["playerFirstName" : self.arrPlay[indexPath.row].pfName, "playerLastName":self.arrPlay[indexPath.row].plName, "position1" : self.arrPlay[indexPath.row].pos1, "position2": self.arrPlay[indexPath.row].pos2, "parentName":self.arrPlay[indexPath.row].parentFN, "playerEmail" : self.arrPlay[indexPath.row].playerEm, "kitNumber" : self.arrPlay[indexPath.row].kitNum, "parentEmail":self.arrPlay[indexPath.row].parentEm, "phoneNumber": self.arrPlay[indexPath.row].phoneNum]
                    self.ref?.child("teams").child(self.tid).child("startingLineUp").child(self.ft).child(self.arrPlay[indexPath.row].pfName+self.arrPlay[indexPath.row].kitNum).setValue(playersDict)
                    self.firstCall = false
                    //cell.contentView.backgroundColor = UIColor(
                    tableView.reloadData()
                })
                
            }))
            alert.addAction(UIAlertAction(title: "Remove", style: .default, handler: { (action) in
                self.ref?.child("teams").child(self.tid).child("startingLineUp").child(self.ft).child(self.arrPlay[indexPath.row].pfName+self.arrPlay[indexPath.row].kitNum).removeValue()
            }))
            alert.addAction(UIAlertAction(title: "Edit", style: .default, handler: { (action) in
                self.udef.set(true, forKey: "isUpdated")
                self.performSegue(withIdentifier: "toAddPlayer", sender: self)
                
            }))
            alert.addAction(UIAlertAction(title: "Remove All", style: .default, handler: { (action) in
                self.ref?.child("teams").child(self.tid).child("startingLineUp").child(self.ft).removeValue()
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView,cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tcell = tableView.dequeueReusableCell(withIdentifier: "tcell") as! TeamCell
        
        tcell.playerFullName.text = self.arrPlay[indexPath.row].pfName + " "+self.arrPlay[indexPath.row].plName
        tcell.kitNumber.text = self.arrPlay[indexPath.row].kitNum
        tcell.emailAddresses.text = self.arrPlay[indexPath.row].playerEm + " "+self.arrPlay[indexPath.row].parentEm
        tcell.phoneNumber.text = self.arrPlay[indexPath.row].phoneNum
        tcell.playerPositions.text = "Positions: "+self.arrPlay[indexPath.row].pos1+" "+self.arrPlay[indexPath.row].pos2
        tcell.parentName.text = self.arrPlay[indexPath.row].parentFN
        self.firstCall = true
        //tableView.reloadData()
        
        if ( lineup.contains(where: {$0.pfName == self.arrPlay[indexPath.row].pfName}) && lineup.contains(where: {$0.kitNum == self.arrPlay[indexPath.row].kitNum})){
               print ("set selected image \(lineup[0].pfName)")
                tcell.startingIm.isHidden = false
                tcell.startingIm.image = #imageLiteral(resourceName: "blueplayer")
            } else {
                tcell.startingIm.isHidden = true
            }
        

        
        return tcell


    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrPlay.count
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete){
            if (arrPlay.count > 0){
            ref?.child("users").child((Auth.auth().currentUser?.uid)!).observeSingleEvent(of: .value, with: { (snapshot) in
                let val = snapshot.value as? NSDictionary
                self.tid = val?["teamID"] as? String ?? ""
                self.ref?.child("teams").child(self.tid).child("players").child(self.arrPlay[indexPath.row].pfName+self.arrPlay[indexPath.row].kitNum).removeValue()
                self.ref?.child("teams").child(self.tid).child("startingLineUp").child(self.ft).child(self.arrPlay[indexPath.row].pfName+self.arrPlay[indexPath.row].kitNum).removeValue()
                self.arrPlay.remove(at: indexPath.row)
                tableView.reloadData()
            })
            }
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        if (isPlayer)!{
            return .none
        } else {
            return .delete
        }
    }
    

    @IBAction func changeCrest(_ sender: Any) {
        /*
        picker = UIImagePickerController()
        picker?.delegate = self
        picker?.sourceType = .photoLibrary
       // picker?.preferredInterfaceOrientationForPresentation = .landscapeLeft
        //picker?.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        picker?.allowsEditing = true
        present(picker!, animated: true, completion: nil)*/
        
        let imPicker = DKImagePickerController()
        imPicker.singleSelect = true
        imPicker.maxSelectableCount = 1
        imPicker.allowsLandscape = true
        imPicker.allowMultipleTypes = false
        imPicker.sourceType = .both
        imPicker.assetType = .allPhotos
        //imPicker.didCancel
        imPicker.didSelectAssets = { (assets: [DKAsset]) in
            print("didSelectAssets")
            print("assets \(assets)")
            if (assets.count > 0){
            _  = assets[0].fetchOriginalImageWithCompleteBlock({ (selected, _: [AnyHashable : Any]?) in
                self.teamLogo.setImage(selected, for: .normal)
                self.ref?.child("users").child((Auth.auth().currentUser?.uid)!).observeSingleEvent(of: .value, with: { (snapshot) in
                    let val = snapshot.value as? NSDictionary
                    self.tid = val?["teamID"] as? String ?? ""
                    let storage = Storage.storage().reference().child(self.tid).child("teamCrest").child("teamCrest.png")
                    if let uploadData = UIImagePNGRepresentation(self.teamLogo.currentImage!){
                        storage.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                            if let err = error{
                                print("imageerror \(err)")
                                return
                            } else {
                                _ = metadata!.downloadURL()
                            }
                        })
                    }
                    
                })

            })
            }
            
        }
        present(imPicker, animated: true, completion: nil)
        }
    
        
    @IBAction func addPlayer(_ sender: Any) {
        self.udef.set(false, forKey: "isUpdated")
        performSegue(withIdentifier: "toAddPlayer", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let isUpdated = UserDefaults.standard.bool(forKey: "isUpdated")
        let dest = segue.destination as! AddPlayerViewController
        if (isUpdated){
            if let ip = self.teamTable.indexPathForSelectedRow{
                let selPlayer = arrPlay[ip.row]
                dest.updatedPlayer = selPlayer
            }
        }
            }
    

}
