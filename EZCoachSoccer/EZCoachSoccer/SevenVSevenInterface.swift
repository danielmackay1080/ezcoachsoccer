//
//  SevenVSevenInterface.swift
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

public class SevenVSevenInterface : SKScene{
    
    var gk7 : SKSpriteNode?
    var lcb7 : SKSpriteNode?
    var rcb7 : SKSpriteNode?
    var cm7 : SKSpriteNode?
    var rm7 : SKSpriteNode?
    var lm7 : SKSpriteNode?
    var str7 : SKSpriteNode?
    
    var opgk7 : SKSpriteNode?
    var oplcb7 : SKSpriteNode?
    var oprcb7 : SKSpriteNode?
    var opcm7 : SKSpriteNode?
    var oplm7: SKSpriteNode?
    var oprm7 : SKSpriteNode?
    var opstr7: SKSpriteNode?
    
    var ball7 : SKSpriteNode?
    
    public override func didMove(to view: SKView) {
        
        gk7 = childNode(withName: "gk7") as? SKSpriteNode!
        lcb7 = childNode(withName: "lcb7") as? SKSpriteNode!
        rcb7 = childNode(withName: "rcb7") as? SKSpriteNode!
        cm7 = childNode(withName: "cm7") as? SKSpriteNode!
        rm7 = childNode(withName: "rm7") as? SKSpriteNode!
        lm7 = childNode(withName: "lm7") as? SKSpriteNode!
        str7 = childNode(withName: "str7") as? SKSpriteNode!
        
        opgk7 = childNode(withName: "opgk7") as? SKSpriteNode!
        oplcb7 = childNode(withName: "oplcb7") as? SKSpriteNode!
        oprcb7 = childNode(withName: "oprcb7") as? SKSpriteNode!
        opcm7 = childNode(withName: "opcm7") as? SKSpriteNode!
        oplm7 = childNode(withName: "oplm7") as? SKSpriteNode!
        oprm7 = childNode(withName: "oprm7") as? SKSpriteNode!
        opstr7 = childNode(withName: "opstr7") as? SKSpriteNode!
        
        ball7 = childNode(withName: "ball7") as? SKSpriteNode!
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let tl = touch.location(in: self)
            if let node = self.atPoint(tl) as? SKSpriteNode{
                if (node.name == "ball7"){
                    ball7?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == "gk7"){
                    gk7?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == "lcb7"){
                    lcb7?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == "rcb7"){
                    rcb7?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == "cm7"){
                    cm7?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == "lm7"){
                    lm7?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == "rm7"){
                    rm7?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == "str7"){
                    str7?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == "opgk7"){
                    opgk7?.position = CGPoint(x: tl.x, y: tl.y)
                }else if (node.name == "oplcb7"){
                    oplcb7?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == "oprcb7"){
                    oprcb7?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == "opcm7"){
                    opcm7?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == "oplm7"){
                    oplm7?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == "oprm7"){
                    oprm7?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == "opstr7"){
                    opstr7?.position = CGPoint(x: tl.x, y: tl.y)
                }
            }
        }
    }
    
}
