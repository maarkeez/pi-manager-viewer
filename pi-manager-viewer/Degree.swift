//
//  Degree.swift
//  pi-manager-viewer
//
//  Created by David Márquez Delgado on 17/11/2019.
//  Copyright © 2019 David Márquez Delgado. All rights reserved.
//

import Foundation

class Degree {
    private var degree : Double
    
    init(degree: Double){
        self.degree = degree
    }
    
    public func getDegree() -> Double{
        return degree
    }
}
