//
//  CpuService.swift
//  pi-manager-viewer
//
//  Created by David Márquez Delgado on 29/11/2019.
//  Copyright © 2019 David Márquez Delgado. All rights reserved.
//

import Foundation

import PromiseKit
import SwiftyJSON

class CpuUsageService {
    
    private let internalCall = CpuUsageCall();
    
    private init() {}
    
    public static func singleton() -> CpuUsageService {
        return CpuUsageService()
    }
    
    func readCpuUsage() -> Promise<CpuUsage> {
        return internalCall.call();
    }
}


private class CpuUsageCall: GetPromise<CpuUsage> {
    
    override func getUrl() -> String {return "/api/system/metrics/cpu"}
    
    override func deSerialize(_ json:JSON) -> CpuUsage? {
        let used = json["used"].double!
        let total = json["total"].double!

        return CpuUsage(used: used, total: total)
        
    }
    
}
