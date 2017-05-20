//
//  ElevenVElevenInterface.swift
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

public class ElevenVElevenInterface: SKScene{
    
    var gk11, lcb11, rcb11, rb11,lb11,rcm11,cm11,lcm11,rf11,lf11,str11,ball11 : SKSpriteNode?
    var opgk11, oplcb11, oprcb11, oprb11, oplb11,oprcm11,opcm11,oplcm11,oprf11,oplf11,opstr11 : SKSpriteNode?
    
    public override func didMove(to view: SKView) {
        ball11 = childNode(withName: "ball11") as? SKSpriteNode!
        gk11 = childNode(withName: "gk11") as? SKSpriteNode!
        lcb11 = childNode(withName: "lcb11") as? SKSpriteNode!
        rcb11 = childNode(withName: "rcb11") as? SKSpriteNode!
        lb11 = childNode(withName: "lb11") as? SKSpriteNode!
        rb11 = childNode(withName: "rb11") as? SKSpriteNode!
        rcm11 = childNode(withName: "rcm11") as? SKSpriteNode!
        lcm11 = childNode(withName: "lcm11") as? SKSpriteNode!
        cm11 = childNode(withName: "cm11") as? SKSpriteNode!
        rf11 = childNode(withName: "rf11") as? SKSpriteNode!
        lf11 = childNode(withName: "lf11") as? SKSpriteNode!
        str11 = childNode(withName: "str11") as? SKSpriteNode!
        
        opgk11 = childNode(withName: "opgk11") as? SKSpriteNode!
        oplcb11 = childNode(withName: "oplcb11") as? SKSpriteNode!
        oprcb11 = childNode(withName: "oprcb11") as? SKSpriteNode!
        oprb11 = childNode(withName: "oprb11") as? SKSpriteNode!
        oplb11 = childNode(withName: "oplb11") as? SKSpriteNode!
        oprcm11 = childNode(withName: "oprcm11") as? SKSpriteNode!
        oplcm11 = childNode(withName: "oplcm11") as? SKSpriteNode!
        opcm11 = childNode(withName: "opcm11") as? SKSpriteNode!
        oprf11 = childNode(withName: "oprf11") as? SKSpriteNode!
        oplf11 = childNode(withName: "oplf11") as? SKSpriteNode!
        opstr11 = childNode(withName: "opstr11") as? SKSpriteNode!
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let tl = touch.location(in: self)
            if let node = self.atPoint(tl) as? SKSpriteNode{
                if (node.name == ball11?.name){
                    ball11?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == gk11?.name){
                    gk11?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == lcb11?.name){
                    lcb11?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == rcb11?.name){
                    rcb11?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == lb11?.name){
                    lb11?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == rb11?.name){
                    rb11?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == rcm11?.name){
                    rcm11?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == lcm11?.name){
                    lcm11?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == cm11?.name){
                    cm11?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == rf11?.name){
                    rf11?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == lf11?.name){
                    lf11?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == str11?.name){
                    str11?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == opgk11?.name){
                    opgk11?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == oplcb11?.name){
                    oplcb11?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == oprcb11?.name){
                    oprcb11?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == oprb11?.name){
                    oprb11?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == oplb11?.name){
                    oplb11?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == oprcm11?.name){
                    oprcm11?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == oplcm11?.name){
                    oplcm11?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == opcm11?.name){
                    opcm11?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == oprf11?.name){
                    oprf11?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == oplf11?.name){
                    oplf11?.position = CGPoint(x: tl.x, y: tl.y)
                } else if (node.name == opstr11?.name){
                    opstr11?.position = CGPoint(x: tl.x, y: tl.y)
                }
            }
        }
    }
}
