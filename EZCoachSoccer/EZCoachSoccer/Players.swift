//
//  Players.swift
//  EZCoachSoccer
//
//  Created by Daniel Mackay on 5/22/17.
//  Copyright © 2017 Daniel Mackay. All rights reserved.
//

import Foundation

public class Players {
    
    var pfName, plName, pos1, pos2, parentEm, playerEm, parentFN : String
    var kitNum, phoneNum : String
    
    init(pfName : String, plName : String, pos1 : String, pos2 : String, parentEm : String, playerEm : String, parentFN : String, kitNum : String, phoneNum : String) {
        self.pfName = pfName
        self.kitNum = kitNum
        self.phoneNum = phoneNum
        self.plName = plName
        self.pos1 = pos1
        self.pos2 = pos2
        self.parentEm = parentEm
        self.playerEm = playerEm
        self.parentFN = parentFN
    }
}
