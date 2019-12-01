//
//  FileManagerService.swift
//  pi-manager-viewer
//
//  Created by David Márquez Delgado on 01/12/2019.
//  Copyright © 2019 David Márquez Delgado. All rights reserved.
//

import Foundation
import PromiseKit
import SwiftyJSON

class FileManagerService {
    
    private let describeHomeCall = DescribeHomeCall();
    
    private init() {}
    
    public static func singleton() -> FileManagerService {
        return FileManagerService()
    }
    
    func describeHome() -> Promise<FileDescribe> {
        return describeHomeCall.call();
    }
}


private class DescribeHomeCall: GetPromise<FileDescribe> {
    
    override func getUrl() -> String {return "api/filemanager/describe/home"}
    
    override func deSerialize(_ json:JSON) -> FileDescribe? {
        let directory = json["directory"].string!
        var files : [FileModel] = []
        
        let filesJsonArray = json["files"].array!
        for fileJson in filesJsonArray {
            let name = fileJson["name"].string!
            let size = fileJson["size"].string!
            var type = FileType.FILE
            let typeStr = fileJson["type"].string!
            if "FOLDER" == typeStr {
                type = FileType.FOLDER
            }
            
            let fileModel = FileModel(name: name, size: size, type: type)
            files.append(fileModel)
        }
        
        return FileDescribe(directory: directory, files: files)
        
        
    }
    
}
