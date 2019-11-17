//
//  TemperatureService.swift
//  pi-manager-viewer
//
//  Created by David Márquez Delgado on 17/11/2019.
//  Copyright © 2019 David Márquez Delgado. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit
import SwiftyJSON

class TemperatureService {
    
    private let degree = DegreeCall();
    
    private init() {}
    
    public static func singleton() -> TemperatureService {
        return TemperatureService()
    }
    
    func readTemperature() -> Promise<Temperature> {
        return degree.call();
    }
}


private class DegreeCall: GetPromise<Temperature> {
    
    override func getUrl() -> String {return "/api/degree"}
    
    override func deSerialize(_ json:JSON) -> Temperature? { return Temperature(degree: json["degrees"].double!)}
    
}
