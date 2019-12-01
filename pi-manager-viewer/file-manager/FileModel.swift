//
//  FileModel.swift
//  pi-manager-viewer
//
//  Created by David Márquez Delgado on 01/12/2019.
//  Copyright © 2019 David Márquez Delgado. All rights reserved.
//

import Foundation

class FileModel {
    
    private let name: String
    private let size: String
    private let type: FileType
    
    init(name: String, size: String ,type: FileType){
        self.name = name
        self.size = size
        self.type = type
    }
    
    public func getName() -> String{
        return name
    }
    
    public func getSize() -> String {
        return size
    }
    
    public func getType() -> FileType{
        return type
    }
}
