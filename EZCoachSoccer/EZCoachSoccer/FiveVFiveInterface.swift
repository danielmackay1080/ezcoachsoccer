//
//  FiveVFiveInterface.swift
//  EZCoachSoccer
//
//  Created by Daniel Mackay on 5/17/17.
//  Copyright © 2017 Daniel Mackay. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit
import CoreTelephony
import SystemConfiguration

public class FiveVFiveInterface: SKScene{
    
    var gk5 : SKSpriteNode?
    var opGk5 : SKSpriteNode?
    var lcb5 : SKSpriteNode?
    var oplcb5 : SKSpriteNode?
    var rcb5 : SKSpriteNode?
    var oprcb5 : SKSpriteNode?
    var lf5 : SKSpriteNode?
    var oplf5 : SKSpriteNode?
    var rf5 : SKSpriteNode?
    var oprf5 : SKSpriteNode?
    var ball5 : SKSpriteNode?
    
    public override func didMove(to view: SKView) {
        gk5 = childNode(withName: "gk5") as! SKSpriteNode!
        opGk5 = childNode(withName: "opgk5") as! SKSpriteNode!
        lcb5 = childNode(withName: "lcb5") as! SKSpriteNode!
        oplcb5 = childNode(withName: "oplcb5") as! SKSpriteNode!
        rcb5 = childNode(withName: "rcb5") as! SKSpriteNode!
        oprcb5 = childNode(withName: "oprcb5") as! SKSpriteNode!
        rf5 = childNode(withName: "rf5") as! SKSpriteNode!
        oprf5 = childNode(withName: "oprf5") as! SKSpriteNode!
        lf5 = childNode(withName: "lf5") as! SKSpriteNode!
        oplf5 = childNode(withName: "oplf5") as! SKSpriteNode!
        ball5 = childNode(withName: "ball5") as! SKSpriteNode!
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) { // moves players and ball
        for touch in touches{
            let tl = touch.location(in: self)
            if let node = self.atPoint(tl) as? SKSpriteNode{
                if (node.name == "gk5"){
                    gk5?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == "opgk5"){
                    opGk5?.position = CGPoint(x: tl.x, y: tl.y)
                }else if (node.name == "lcb5"){
                    lcb5?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == "oplcb5"){
                    oplcb5?.position = CGPoint(x: tl.x, y: tl.y)
                }else if (node.name == "rcb5"){
                    rcb5?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == "oprcb5"){
                    oprcb5?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == "rf5"){
                    rf5?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == "oprf5"){
                    oprf5?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == "lf5"){
                    lf5?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == "oplf5"){
                    oplf5?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == "ball5"){
                    ball5?.position = CGPoint(x: tl.x, y: tl.y)
                }
            }
        }
    }
    
}
