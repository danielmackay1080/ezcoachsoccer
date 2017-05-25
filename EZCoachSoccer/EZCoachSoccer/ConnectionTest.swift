//
//  ConnectionTest.swift
//  EZCoachSoccer
//
//  Created by Daniel Mackay on 5/16/17.
//  Copyright © 2017 Daniel Mackay. All rights reserved.
//

import Foundation
import SystemConfiguration

public class ConnectionTest { // test internet connection
    
    class func isConnected()->Bool{
        var address = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr:0), sin_zero: (0,0,0,0,0,0,0,0))
        address.sin_len = UInt8(MemoryLayout.size(ofValue: address))
        address.sin_family = sa_family_t(AF_INET)
        
        guard let netReachable = withUnsafePointer(to: &address, {
            $0.withMemoryRebound(to: sockaddr.self, capacity:1 ){
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags : SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(netReachable, &flags) {
            return false
        }
        let isReached = flags.contains(.reachable)
        let isRequired = flags.contains(.connectionRequired)
        
        return (isReached && !isRequired)
    }

}
