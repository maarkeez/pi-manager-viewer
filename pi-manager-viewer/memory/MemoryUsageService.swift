//
//  MemoryService.swift
//  pi-manager-viewer
//
//  Created by David Márquez Delgado on 29/11/2019.
//  Copyright © 2019 David Márquez Delgado. All rights reserved.
//

import Foundation
import PromiseKit
import SwiftyJSON

class MemoryUsageService {
    
    private let internalCall = MemoryUsageCall();
    
    private init() {}
    
    public static func singleton() -> MemoryUsageService {
        return MemoryUsageService()
    }
    
    func readMemoryUsage() -> Promise<MemoryUsage> {
        return internalCall.call();
    }
}


private class MemoryUsageCall: GetPromise<MemoryUsage> {
    
    override func getUrl() -> String {return "/api/system/metrics/memory"}
    
    override func deSerialize(_ json:JSON) -> MemoryUsage? {
        let used = json["used"].double!
        let total = json["total"].double!
        
        return MemoryUsage(used: used, total: total)
        
    }
    
}
