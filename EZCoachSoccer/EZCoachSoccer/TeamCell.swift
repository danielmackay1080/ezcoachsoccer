//
//  TeamCell.swift
//  EZCoachSoccer
//
//  Created by Daniel Mackay on 5/22/17.
//  Copyright © 2017 Daniel Mackay. All rights reserved.
//

import UIKit

class TeamCell: UITableViewCell {

    @IBOutlet weak var playerFullName: UILabel!
    
    @IBOutlet weak var playerPositions: UILabel!
    
    @IBOutlet weak var emailAddresses: UILabel!
    
    @IBOutlet weak var kitNumber: UILabel!
    
    @IBOutlet weak var parentName: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
