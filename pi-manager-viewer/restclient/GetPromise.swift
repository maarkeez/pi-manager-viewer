//
//  GetPromise.swift
//  pi-manager-viewer
//
//  Created by David Márquez Delgado on 17/11/2019.
//  Copyright © 2019 David Márquez Delgado. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit
import SwiftyJSON


class GetPromise<T>{
    
    func call() -> Promise<T> {
        return Promise { seal in
            Alamofire.request(ServerConstants.baseUrl + getUrl(), method: .get).responseJSON { response in
                switch response.result {
                case .success(let json):
                    let jsonObj = JSON(json)
                    seal.fulfill(self.deSerialize(jsonObj)!)
                    
                case .failure(let error):
                    seal.reject(error)
                }
            }
        }
    }
    
    // Must be overriden
    func getUrl() -> String {return ""}
    
    // Must be overriden
    func deSerialize(_ json:JSON) -> T? { return nil}
    
}
