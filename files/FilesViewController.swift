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
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    

}

extension FilesViewController : UITableViewDelegate {
 
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(integerLiteral: 60)
    }
}


extension FilesViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let myTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! FilesViewCellTableViewCell
        myTableViewCell.setFileName("myFile.txt")
        myTableViewCell.setFileSize("48 MB")
        
        if(indexPath.row % 2 == 0){
            myTableViewCell.setFileType()
        }else{
            myTableViewCell.setFolderType()
        }
        return myTableViewCell
    }
    
}
