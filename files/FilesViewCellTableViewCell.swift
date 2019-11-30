//
//  FilesViewCellTableViewCell.swift
//  pi-manager-viewer
//
//  Created by David Márquez Delgado on 30/11/2019.
//  Copyright © 2019 David Márquez Delgado. All rights reserved.
//

import UIKit

class FilesViewCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var myInternalView: UIView!
    @IBOutlet weak var myFileImage: UIImageView!
    @IBOutlet weak var myFileName: UILabel!
    @IBOutlet weak var myFileSize: UILabel!
    
    static let fileImg = #imageLiteral(resourceName: "file")
    static let folderImg = #imageLiteral(resourceName: "folder")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor  = UiConstants.DARK_GREY
        myInternalView.backgroundColor  = UiConstants.SOFT_GREY
        myFileName.textColor  = UiConstants.SOFT_YELLOW
        myFileSize.textColor  = UiConstants.BLUE
        self.selectionStyle = .none
    }
    
    public func setFileName(_ fileName: String) {
        myFileName.text = fileName
    }
    
    public func setFileSize(_ fileSize: String) {
        myFileSize.text = fileSize
    }
    
    public func setFileType(){
        myFileImage.image = FilesViewCellTableViewCell.fileImg
    }
    
    public func setFolderType(){
        myFileImage.image = FilesViewCellTableViewCell.folderImg
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        if(highlighted){
            myInternalView.layer.borderColor = UiConstants.BLUE.cgColor
            myInternalView.layer.borderWidth = 1.0;
            myInternalView.backgroundColor  = UiConstants.DARK_GREY
        }else{
            myInternalView.layer.borderWidth = 0.0;
            myInternalView.backgroundColor  = UiConstants.SOFT_GREY
        }
    }
    
    
}
