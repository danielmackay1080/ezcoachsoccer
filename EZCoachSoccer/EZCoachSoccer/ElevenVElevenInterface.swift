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
    
    // formation animations
    // 4-3-3
    var STR433 = SKAction.move(to: CGPoint(x: 96.203, y: -2.689), duration: 1)
    var rf433 = SKAction.move(to: CGPoint(x: 96.203, y: 222.311), duration: 1)
    var lf433 = SKAction.move(to: CGPoint(x: 96.203, y: -251.763), duration: 1)
    var rcm433 = SKAction.move(to: CGPoint(x: 273.203, y: -151.763), duration: 1)
    var lcm433 = SKAction.move(to: CGPoint(x: 273.203, y: 150.311), duration: 1)
    var cm433 = SKAction.move(to: CGPoint(x: 273.203, y: -2.689), duration: 1)
    var lb433 = SKAction.move(to: CGPoint(x: 405.203, y: -296.689), duration: 1)
    var rb433 = SKAction.move(to: CGPoint(x: 390.203, y: 288.311), duration: 1)
    var rcb433 = SKAction.move(to: CGPoint(x: 429.25, y: 98.786), duration: 1)
    var lcb433 = SKAction.move(to: CGPoint(x: 429.25, y: -101.214), duration: 1)
    
    // 4-4-2
    var lb442 = SKAction.move(to: CGPoint(x: 405.203, y: -296.689), duration: 1)
    var rb442 = SKAction.move(to: CGPoint(x: 390.203, y: 288.311), duration: 1)
    var rcb442 = SKAction.move(to: CGPoint(x: 429.25, y: 98.786), duration: 1)
    var lcb442 = SKAction.move(to: CGPoint(x: 429.25, y: -101.214), duration: 1)
    var rf442 = SKAction.move(to: CGPoint(x: 232.175, y: 269.69), duration: 1)
    var lcm442 = SKAction.move(to: CGPoint(x: 273.203, y: 97.311), duration: 1)
    var cm442 = SKAction.move(to: CGPoint(x: 273.203, y: -77.689), duration: 1)
    var rcm442 = SKAction.move(to: CGPoint(x: 243.005, y: -251.763), duration: 1)
    var str442 = SKAction.move(to: CGPoint(x: 92.203, y: 97.311), duration: 1)
    var lf442 = SKAction.move(to: CGPoint(x: 93.203, y: -62.966), duration: 1)
    
    // 4-2-3-1
    var lb4231 = SKAction.move(to: CGPoint(x: 405.203, y: -296.689), duration: 1)
    var rb4231 = SKAction.move(to: CGPoint(x: 390.203, y: 288.311), duration: 1)
    var rcb4231 = SKAction.move(to: CGPoint(x: 429.25, y: 98.786), duration: 1)
    var lcb4231 = SKAction.move(to: CGPoint(x: 429.25, y: -101.214), duration: 1)
    var cm4231 = SKAction.move(to: CGPoint(x: 302.203, y: -77.689), duration: 1)
    var lcm4231 = SKAction.move(to: CGPoint(x: 302.203, y: 72.311), duration: 1)
    var rf4231 = SKAction.move(to: CGPoint(x: 174.547, y: -101.214), duration: 1)
    var lf4231 = SKAction.move(to: CGPoint(x: 175.474, y: -2.689), duration: 1)
    var rcm4231 = SKAction.move(to: CGPoint(x: 175.474, y: -101.214), duration: 1)
    var str4231 = SKAction.move(to: CGPoint(x: 75.474, y: -2.689), duration: 1)
    
    // 3-4-3
    var rb343 = SKAction.move(to: CGPoint(x: 429.25, y: 198.786), duration: 1)
    var rcb343 = SKAction.move(to: CGPoint(x: 429.25, y: -15.739), duration: 1)
    var lcb343 = SKAction.move(to: CGPoint(x: 429.25, y: -215.739), duration: 1)
    var lf343 = SKAction.move(to: CGPoint(x: 266.727, y: 298.786), duration: 1)
    var lcm343 = SKAction.move(to: CGPoint(x: 266.727, y: 72.311), duration: 1)
    var cm343 = SKAction.move(to: CGPoint(x: 266.727, y: -102.689), duration: 1)
    var lb343 = SKAction.move(to: CGPoint(x: 266.727, y: 315.739), duration: 1)
    var str343 = SKAction.move(to: CGPoint(x: 75.474, y: -2.689), duration: 1)
    var rcm343 = SKAction.move(to: CGPoint(x: 75.474, y: -181.876), duration: 1)
    var rf343 = SKAction.move(to: CGPoint(x: 75.474, y: 172.311), duration: 1)
    
    // 5-3-2
    var rb532 = SKAction.move(to: CGPoint(x: 429.25, y: 198.786), duration: 1)
    var rcb532 = SKAction.move(to: CGPoint(x: 429.25, y: -15.739), duration: 1)
    var lcb532 = SKAction.move(to: CGPoint(x: 429.25, y: -215.739), duration: 1)
    var lb532 = SKAction.move(to: CGPoint(x: 350.551, y: -315.739), duration: 1)
    var lcm532 = SKAction.move(to: CGPoint(x: 264.828, y: 122.311), duration: 1)
    var cm532 = SKAction.move(to: CGPoint(x: 264.828, y: -15.739), duration: 1)
    var rcm532 = SKAction.move(to: CGPoint(x: 264.828, y: -170.077), duration: 1)
    var str532 = SKAction.move(to: CGPoint(x: 94.843, y: -81.876), duration: 1)
    var lf532 = SKAction.move(to: CGPoint(x: 350.551, y: 297.786), duration: 1)
    var rf532 = SKAction.move(to: CGPoint(x: 94.834, y: 50.311), duration: 1)
    
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
    
    func form433(){
        lcb11?.run(lcb433)
        rcb11?.run(rcb433)
        rb11?.run(rb433)
        lb11?.run(lb433)
        cm11?.run(cm433)
        rcm11?.run(rcm433)
        lcm11?.run(lcm433)
        lf11?.run(lf433)
        rf11?.run(rf433)
        str11?.run(STR433)
    }
    
    func form442(){
        lcb11?.run(lcb442)
        rcb11?.run(rcb442)
        lb11?.run(lb442)
        rb11?.run(rb442)
        cm11?.run(cm442)
        rcm11?.run(rcm442)
        lcm11?.run(lcm442)
        lf11?.run(lf442)
        rf11?.run(rf442)
        str11?.run(str442)
    }
    
    func form4231(){
        lcb11?.run(lcb4231)
        rcb11?.run(rcb4231)
        rb11?.run(rb4231)
        lb11?.run(lb4231)
        cm11?.run(cm4231)
        rcm11?.run(rcm4231)
        lcm11?.run(lcm4231)
        rf11?.run(rf4231)
        lf11?.run(lf4231)
        str11?.run(str4231)
    }
    
    func form343(){
        lcb11?.run(lcb343)
        rcb11?.run(rcb343)
        lb11?.run(lb343)
        rb11?.run(rb343)
        cm11?.run(cm343)
        rcm11?.run(rcm343)
        lcm11?.run(lcm343)
        rf11?.run(rf343)
        lf11?.run(lf343)
        str11?.run(str343)
    }
    
    func form532(){
        lcb11?.run(lcb532)
        rcb11?.run(rcb532)
        rb11?.run(rb532)
        lb11?.run(lb532)
        cm11?.run(cm532)
        lcm11?.run(lcm532)
        rcm11?.run(rcm532)
        rf11?.run(rf532)
        lf11?.run(lf532)
        str11?.run(str532)
    }
}
