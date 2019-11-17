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
    
    private init(){}
    
    public static func singleton() -> TemperatureService {
        return TemperatureService()
    }
    
    private func getBaseUrl() -> String {
        return "http://10.10.1.108:8080"
    }
    
    func readTemperature() -> Promise<Degree> {
        
        return Promise { seal in
            Alamofire.request(getBaseUrl() + "/api/degree", method: .get).responseJSON { response in
                switch response.result {
                case .success(let json):
                    let jsonObj = JSON(json)
                    seal.fulfill(Degree(degree: jsonObj["degrees"].double!))
                    
                case .failure(let error):
                    seal.reject(error)
                }
            }
        }
    }
}

