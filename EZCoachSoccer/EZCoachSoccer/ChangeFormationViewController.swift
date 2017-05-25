//
//  ChangeFormationViewController.swift
//  EZCoachSoccer
//
//  Created by Daniel Mackay on 5/24/17.
//  Copyright © 2017 Daniel Mackay. All rights reserved.
//

import UIKit

class ChangeFormationViewController: ViewController, UITableViewDelegate, UITableViewDataSource {
    
    var arr = ["4-1-4-1" , "3-1-4-2"]

    @IBOutlet weak var cFormationTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
