//
//  Reachability.swift
//  ZipFlix
//
//  Created by Wouter Willebrands on 18/11/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import SystemConfiguration

// Object that check wether we have internet connection
struct Reachability {
    
    private static let reachability = SCNetworkReachabilityCreateWithName( kCFAllocatorDefault, "www.wouterwillebrands.com")
    
    static func checkReachable() -> Bool {
        var flags = SCNetworkReachabilityFlags()
        SCNetworkReachabilityGetFlags(self.reachability!, &flags)
        
        var isReachable: Bool = false
        
        if (isNetworkRachable(with: flags)) {
            if flags.contains(.isWWAN) {
                isReachable = true
            } else {
                isReachable = true
            }
    
        } else if (!isNetworkRachable(with: flags)) {
            isReachable = false
        }
        
        return isReachable
    }
    
    private static func isNetworkRachable(with flags: SCNetworkReachabilityFlags) -> Bool {
        let isReachble = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        let canConnectAutomatically = flags.contains(.connectionOnDemand) || flags.contains(.connectionOnTraffic)
        let canConnectWithoutUserInteraction = canConnectAutomatically && !flags.contains(.interventionRequired)
        return isReachble && (!needsConnection || canConnectWithoutUserInteraction)
    }
}
