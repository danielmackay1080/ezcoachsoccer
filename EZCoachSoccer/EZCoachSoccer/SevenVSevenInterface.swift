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
    
    // formations
    // 3-3
    var lcb33 = SKAction.move(to: CGPoint(x: 449.765, y: -233.665), duration: 1)
    var rcb33 = SKAction.move(to: CGPoint(x: 449.765, y: 217.601), duration: 1)
    var cm33 = SKAction.move(to: CGPoint(x: 412.012, y: -2.845), duration: 1)
    var rm33 = SKAction.move(to: CGPoint(x: 194.924, y: 217.601), duration: 1)
    var lm33 = SKAction.move(to: CGPoint(x: 194.924, y: -233.665), duration: 1)
    var st33 = SKAction.move(to: CGPoint(x: 91.331, y: -2.845), duration: 1)
    
    //3-1-2
    var lcb312 = SKAction.move(to: CGPoint(x: 449.765, y: -233.665), duration: 1)
    var rcb312 = SKAction.move(to: CGPoint(x: 449.765, y: 217.601), duration: 1)
    var cm312 = SKAction.move(to: CGPoint(x: 412.012, y: -2.845), duration: 1)
    var rm312 = SKAction.move(to: CGPoint(x: 103.939, y: 127.155), duration: 1)
    var st312 = SKAction.move(to: CGPoint(x: 103.939, y: -119.71), duration: 1)
    var lm312 = SKAction.move(to: CGPoint(x: 250.425, y: -2.845), duration: 1)
    
    // 2-3-1
    var lcb231 = SKAction.move(to: CGPoint(x: 449.765, y: -148.734), duration: 1)
    var rcb231 = SKAction.move(to: CGPoint(x: 449.765, y: 153.196), duration: 1)
    var cm231 = SKAction.move(to: CGPoint(x: 294.788, y: -2.845), duration: 1)
    var rm231 = SKAction.move(to: CGPoint(x: 250.425, y: 227.747), duration: 1)
    var lm231 = SKAction.move(to: CGPoint(x: 250.425, y: -262.845), duration: 1)
    var st231 = SKAction.move(to: CGPoint(x: 120.425, y: -2.845), duration: 1)
    
    //2-1-2-1
    var lcb2121 = SKAction.move(to: CGPoint(x: 449.765, y: -148.734), duration: 1)
    var rcb2121 = SKAction.move(to: CGPoint(x: 449.765, y: 153.196), duration: 1)
    var cm2121 = SKAction.move(to: CGPoint(x: 345.146, y: -1.204), duration: 1)
    var rm2121 = SKAction.move(to: CGPoint(x: 197.707, y: 177.751), duration: 1)
    var lm2121 = SKAction.move(to: CGPoint(x: 197.707, y: -184.983), duration: 1)
    var st2121 = SKAction.move(to: CGPoint(x: 90.785, y: -1.204), duration: 1)
    
    //1-3-2
    var lcb132 = SKAction.move(to: CGPoint(x: 439.309, y: -2.845), duration: 1)
    var rcb132 = SKAction.move(to: CGPoint(x: 288.969, y: 227.747), duration: 1)
    var cm132 = SKAction.move(to: CGPoint(x: 288.969, y: -2.845), duration: 1)
    var lm132 = SKAction.move(to: CGPoint(x: 288.969, y: -248.852), duration: 1)
    var rm132 = SKAction.move(to: CGPoint(x:90.785, y: 128.796), duration: 1)
    var st132 = SKAction.move(to: CGPoint(x: 105.568, y: -118.852), duration: 1)
    
    
    
    
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
    
    func form33(){
        lcb7?.run(lcb33)
        rcb7?.run(rcb33)
        rm7?.run(rm33)
        lm7?.run(lm33)
        cm7?.run(cm33)
        str7?.run(st33)
    }
    
    func form312(){
        lcb7?.run(lcb312)
        rcb7?.run(rcb312)
        rm7?.run(rm312)
        lm7?.run(lm312)
        cm7?.run(cm312)
        str7?.run(st312)
    }
    
    func form231(){
        lcb7?.run(lcb231)
        rcb7?.run(rcb231)
        cm7?.run(cm231)
        lm7?.run(lm231)
        rm7?.run(rm231)
        str7?.run(st231)
    }
    
    func form2121(){
        lcb7?.run(lcb2121)
        rcb7?.run(rcb2121)
        cm7?.run(cm2121)
        lm7?.run(lm2121)
        rm7?.run(rm2121)
        str7?.run(st2121)
    }
    
    func form132(){
        lcb7?.run(lcb132)
        rcb7?.run(rcb132)
        cm7?.run(cm132)
        lm7?.run(lm132)
        rm7?.run(rm132)
        str7?.run(st132)
    }
    
}
