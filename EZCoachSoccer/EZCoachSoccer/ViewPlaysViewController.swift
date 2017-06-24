//
//  ViewPlaysViewController.swift
//  EZCoachSoccer
//
//  Created by Daniel Mackay on 6/2/17.
//  Copyright © 2017 Daniel Mackay. All rights reserved.
//

import UIKit
import Firebase

class ViewPlaysViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var playsView: UICollectionView!
    
    var ref : DatabaseReference?
    var storage : StorageReference?
    var playsArr = [UIImage]()
    var urlArr = [Any]()
    var plaTitles = [String]()
    var user : User?
    var ipr = 0
    var ip : IndexPath?
    var fromtab = false

    override func viewDidLoad() {
        super.viewDidLoad()
        print("view did load")
        playsView.dataSource = self
        playsView.delegate = self
        ref = Database.database().reference()
        user = Auth.auth().currentUser
        loadCollectionData()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("view will appear")
        //loadCollectionData()
        playsView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        ipr = indexPath.row
       //cell.deletePl.isHidden = false
        if (indexPath.row <= playsArr.count){
        performSegue(withIdentifier: "toZoom", sender: self)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return playsArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = playsView.dequeueReusableCell(withReuseIdentifier: "ccell", for: indexPath) as! CollectionViewCell
        ip = indexPath
        cell.playsImage.image = playsArr[indexPath.row]
        cell.playTitle.text = plaTitles[indexPath.row]
        //cell.deletePl.isHidden = true
                return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination as! ViewPlayZoomViewController
        if let paths = self.playsView.indexPathsForSelectedItems{
            print(playsArr)
            let index = paths[0] 
            dest.url = urlArr[index.row] as? String
            dest.bigPlay = playsArr[index.row]
            dest.playTitle = plaTitles[index.row]
        }
    }
    
    func loadCollectionData(){
        self.plaTitles.removeAll()
        self.urlArr.removeAll()
        self.playsArr.removeAll()
        if (user != nil){
            ref?.child("users").child((user?.uid)!).observeSingleEvent(of:.value, with: { (snapshot) in
                let val = snapshot.value as? NSDictionary
                let teamCode = val?["teamID"] as? String ?? ""
                
                self.ref?.child("teams").child(teamCode).observeSingleEvent(of:.value, with: { (snapshot) in
                    let ft = val?["fieldType"] as? String ?? ""
                    self.ref?.child("teams").child(teamCode).child("plays").child(ft).observe(.value, with: { (snapshot) in
                        print("view plays \(self.playsArr.count)")
                        var firstdl = 0
                        for child in snapshot.children{
                            let item = child as! DataSnapshot
                            let url = item.childSnapshot(forPath: "url").value!
                            let title = item.childSnapshot(forPath: "title").value!
                            if (item.hasChild("url") && item.hasChild("title")){
                                print(title)
                                self.urlArr.append(url)
                                self.plaTitles.append(title as! String)
                                self.storage = Storage.storage().reference(forURL: url as! String)
                                self.storage?.getData(maxSize: 1*10000*10000, completion: { (data, error) in
                                    if (firstdl  == 0 ){
                                        self.playsArr.removeAll()
                                        firstdl += 1
                                    }
                                    if let error = error{
                                        print("collection error \(error)")
                                    } else {
                                        let playImage = UIImage(data: data!)
                                        //let cache = NSCache<AnyObject, AnyObject>()
                                        
                                        if (playImage != nil){
                                            DispatchQueue.main.async {
                                                self.playsArr.append(playImage!)
                                                self.playsView.reloadData()
                                                //self.playsView.re
                                                print("collection child \(self.playsArr)")

                                            }
                                            
                                        }
                                    }
                                })
                            }
                            
                            
                            
                        }
                        
                        
                    })
                })
            })
            
        }

    }
    
    func showAlert(alertMessage: String){
        let alert = UIAlertController(title: "Alert", message: alertMessage, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    
}
