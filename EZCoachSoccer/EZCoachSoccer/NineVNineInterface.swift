//
//  NineVNineInterface.swift
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

public class NineVNineInterface : SKScene{
    
    var gk9, cb9, lcb9, rcb9, lcm9, rcm9, rf9, str9, lf9, ball9 : SKSpriteNode?
    var opgk9, opcb9, oplcb9, oprcb9, oplcm9, oprcm9, oprf9, opstr9, oplf9 : SKSpriteNode?
    
    public override func didMove(to view: SKView) {
        
        ball9 = childNode(withName: "ball9") as? SKSpriteNode!
        gk9 = childNode(withName: "gk9") as? SKSpriteNode!
        cb9 = childNode(withName: "cb9") as? SKSpriteNode!
        rcb9 = childNode(withName: "rcb9") as? SKSpriteNode!
        lcb9 = childNode(withName: "lcb9") as? SKSpriteNode!
        lcm9 = childNode(withName: "lcm9") as? SKSpriteNode!
        rcm9 = childNode(withName: "rcm9") as? SKSpriteNode!
        rf9 = childNode(withName: "rf9") as? SKSpriteNode!
        lf9 = childNode(withName: "lf9") as? SKSpriteNode!
        str9 = childNode(withName: "str9") as? SKSpriteNode!
        
        opgk9 = childNode(withName: "opgk9") as? SKSpriteNode!
        opcb9 = childNode(withName: "opcb9") as? SKSpriteNode!
        oplcb9 = childNode(withName: "oplcb9") as? SKSpriteNode!
        oprcb9 = childNode(withName: "oprcb9") as? SKSpriteNode!
        oplcm9 = childNode(withName: "oplcm9") as? SKSpriteNode!
        oprcm9 = childNode(withName: "oprcm9") as? SKSpriteNode!
        oprf9 = childNode(withName: "oprf9") as? SKSpriteNode!
        oplf9 = childNode(withName: "oplf9") as? SKSpriteNode!
        opstr9 = childNode(withName: "opstr9") as? SKSpriteNode!
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches{
            let tl = touch.location(in: self)
            if let node = self.atPoint(tl) as? SKSpriteNode{
                if (node.name == "ball9"){
                    ball9?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == "gk9"){
                    gk9?.position = CGPoint(x: tl.x, y: tl.y)
                }else if (node.name == "lcb9"){
                    lcb9?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == "cb9"){
                    cb9?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == "rcb9"){
                    rcb9?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == "lcm9"){
                    lcm9?.position = CGPoint(x: tl.x, y: tl.y)
                }else if (node.name == "rcm9"){
                    rcm9?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == "rf9"){
                    rf9?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == "lf9"){
                    lf9?.position = CGPoint(x: tl.x, y: tl.y)
                }else if(node.name == "str9"){
                    str9?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == "opgk9"){
                    opgk9?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == "oplcb9"){
                    oplcb9?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == "oprcb9"){
                    oprcb9?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == "opcb9"){
                    opcb9?.position = CGPoint(x: tl.x, y: tl.y)
                }else if (node.name == "oprcm9"){
                    oprcm9?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == "oplcm9"){
                    oplcm9?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == "opstr9"){
                    opstr9?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == "oplf9"){
                    oplf9?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == "oprf9"){
                    oprf9?.position = CGPoint(x: tl.x, y: tl.y)
                }
            }
        }
    }
    
}
