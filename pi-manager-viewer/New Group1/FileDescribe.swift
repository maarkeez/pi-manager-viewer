//
//  FileDescribe.swift
//  pi-manager-viewer
//
//  Created by David Márquez Delgado on 01/12/2019.
//  Copyright © 2019 David Márquez Delgado. All rights reserved.
//

import Foundation


class FileDescribe {
    private let directory: String
    private let files: [FileModel]
    //private String directory;
    // private List<FileModel> files;
    
    init(directory: String, files: [FileModel]){
        self.directory = directory
        self.files = files
    }
    
    public func getDirectory() -> String{
        return directory
    }
    
    public func getFiles() -> [FileModel]{
        return files
    }
}
