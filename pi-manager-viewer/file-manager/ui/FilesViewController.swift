//
//  FilesViewController.swift
//  pi-manager-viewer
//
//  Created by David Márquez Delgado on 30/11/2019.
//  Copyright © 2019 David Márquez Delgado. All rights reserved.
//

import UIKit

class FilesViewController: UIViewController {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var goToBackBtn: UIBarButtonItem!
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var myHeaderView: UIView!
    @IBOutlet weak var myCurrentPathLabel: UILabel!

    let cellIdentifier = "FilesViewCellTableViewCell"
    let fileService = FileManagerService.singleton()
    var fileDescribe : FileDescribe?
    var previousDirectory : [String] = []
    
    // MARK - UI Actions
    override func viewDidLoad() {
        super.viewDidLoad()

        // Navigation bar
        goToBackBtn.tintColor = UiConstants.SOFT_YELLOW
        contentView.backgroundColor = UiConstants.DARK_GREY
        
        // Header
        myHeaderView.backgroundColor = UiConstants.DARK_GREY
        myCurrentPathLabel.textColor = UiConstants.SOFT_YELLOW
        
        // Table
        myTableView.backgroundColor = UiConstants.DARK_GREY
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.separatorStyle = .none
        let fileCell = UINib(nibName: cellIdentifier, bundle: nil)
        myTableView.register(fileCell, forCellReuseIdentifier: cellIdentifier)
        
        describeHomeDirectory()
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func goToPreviousDir(_ sender: UIButton) {
        if previousDirectory.count > 0 {
            if let lastDirectory = previousDirectory.popLast() {
                describeDirectory(lastDirectory, updatePreviousDir: false)
            }
        }
    }
    
    
    // MARK - Functions
    
    private func describeHomeDirectory(){
        fileService.describeHome().done { fileDescribe in
            self.reloadFileDescribe(fileDescribe)
        }.catch{ error in
            self.cleanFileDescribe()
        }
    }
    
    private func describeDirectory(_ directory: String){
        describeDirectory(directory, updatePreviousDir: true)
    }
        
    private func describeDirectory(_ directory: String, updatePreviousDir: Bool){
        fileService.describeDirectory(directory).done { fileDescribe in
            self.reloadFileDescribe(fileDescribe, updatePreviousDir: updatePreviousDir)
        }.catch{ error in
            self.cleanFileDescribe()
        }
    }
    
    private func reloadFileDescribe(_ fileDescribe: FileDescribe){
        reloadFileDescribe(fileDescribe, updatePreviousDir: true)
    }
    
    private func reloadFileDescribe(_ fileDescribe: FileDescribe, updatePreviousDir: Bool){
        if updatePreviousDir {
            if let fileDescribeAux = self.fileDescribe {
                self.previousDirectory.append(fileDescribeAux.getDirectory())
            }
        }
        self.myCurrentPathLabel.text = fileDescribe.getDirectory()
        self.fileDescribe = fileDescribe
        self.myTableView.reloadData()
        if fileDescribe.getFiles().count > 0 {
            self.myTableView.scrollToRow(at: IndexPath.init(row: 0, section: 0), at: .top, animated: true)
        }
    }
    
    private func cleanFileDescribe(){
        self.fileDescribe = nil
    }

}

extension FilesViewController : UITableViewDelegate {
 
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(integerLiteral: 60)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        if let fileDescribeAux = fileDescribe{
            let fileModel = fileDescribeAux.getFiles()[index]
            if FileType.FOLDER ==  fileModel.getType() {
                describeDirectory(fileDescribeAux.getDirectory() + "/" + fileModel.getName())
            }
        }
    }
}


extension FilesViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fileDescribe?.getFiles().count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        
        let myTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! FilesViewCellTableViewCell
        
        let index = indexPath.row
        if let fileModel = fileDescribe?.getFiles()[index]{
            myTableViewCell.setFileModel(fileModel)
        }
        return myTableViewCell
    }
    
}
