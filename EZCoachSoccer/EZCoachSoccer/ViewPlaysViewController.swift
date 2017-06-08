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

    override func viewDidLoad() {
        super.viewDidLoad()
        playsView.dataSource = self
        playsView.delegate = self
        ref = Database.database().reference()
        user = Auth.auth().currentUser
                if (user != nil){
            ref?.child("users").child((user?.uid)!).observe(.value, with: { (snapshot) in
                let val = snapshot.value as? NSDictionary
                let teamCode = val?["teamID"] as? String ?? ""
                
                self.ref?.child("teams").child(teamCode).observe(.value, with: { (snapshot) in
                    let ft = val?["fieldType"] as? String ?? ""
                    self.ref?.child("teams").child(teamCode).child("plays").child(ft).observe(.value, with: { (snapshot) in
                        print("view plays \(self.playsArr.count)")
                        if (self.playsArr.count > 0 ){
                            self.playsArr.removeAll()
                        }
                        if (self.plaTitles.count > 0 ){
                            self.plaTitles.removeAll()
                        }
                        if (self.urlArr.count > 0){
                            self.urlArr.removeAll()
                        }

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
                                if let error = error{
                                    print("collection error \(error)")
                                } else {
                                    let playImage = UIImage(data: data!)
                                    if (playImage != nil){
                                        self.playsArr.append(playImage!)
                                        self.playsView.reloadData()

                                    }
                                }
                            })
                            }

                            
                            print("collection child \(String(describing: title))")
                        }
                    })
                })
            })

        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = playsView.dequeueReusableCell(withReuseIdentifier: "ccell", for: indexPath) as! CollectionViewCell
        ipr = indexPath.row
       //cell.deletePl.isHidden = false
        performSegue(withIdentifier: "toZoom", sender: self)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return playsArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = playsView.dequeueReusableCell(withReuseIdentifier: "ccell", for: indexPath) as! CollectionViewCell
        ip = indexPath
        cell.playsImage.image = playsArr[indexPath.row]
        //cell.deletePl.isHidden = true
                return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination as! ViewPlayZoomViewController
        if let paths = self.playsView.indexPathsForSelectedItems{
            let index = paths[0] 
            dest.url = urlArr[index.row] as? String
            dest.bigPlay = playsArr[index.row]
            dest.playTitle = plaTitles[index.row]
        }
    }
    
    
}
