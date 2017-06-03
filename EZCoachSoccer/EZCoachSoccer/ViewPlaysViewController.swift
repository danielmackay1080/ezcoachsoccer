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
    var user : User?

    override func viewDidLoad() {
        super.viewDidLoad()
        playsView.dataSource = self
        playsView.delegate = self
        ref = Database.database().reference()
        user = Auth.auth().currentUser
        if (user != nil){
            ref?.child("users").child((user?.uid)!).observeSingleEvent(of:.value, with: { (snapshot) in
                let val = snapshot.value as? NSDictionary
                let teamCode = val?["teamID"] as? String ?? ""
                self.ref?.child("teams").child(teamCode).observeSingleEvent(of:.value, with: { (snapshot) in
                    let ft = val?["fieldType"] as? String ?? ""
                    self.ref?.child("teams").child(teamCode).child("plays").child(ft).observe(.value, with: { (snapshot) in
                        for child in snapshot.children{
                            let item = child as! DataSnapshot
                            let url = item.value!
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

                            
                            print("collection child \(item.value)")
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
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return playsArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = playsView.dequeueReusableCell(withReuseIdentifier: "ccell", for: indexPath) as! CollectionViewCell
        cell.playsImage.image = playsArr[indexPath.row]
        return cell
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
