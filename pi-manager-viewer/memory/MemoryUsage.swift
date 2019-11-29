//
//  MemoryUsage.swift
//  pi-manager-viewer
//
//  Created by David Márquez Delgado on 29/11/2019.
//  Copyright © 2019 David Márquez Delgado. All rights reserved.
//

import Foundation

class MemoryUsage{
    private var used : Double
    private var total : Double
    
    init(used: Double, total: Double){
        self.used = used
        self.total = total
    }
    
    public func getUsed() -> Double{
        return used
    }
    
    public func getTotal() -> Double{
        return total
    }
}
