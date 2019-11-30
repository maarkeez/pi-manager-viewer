//
//  CircleViewController.swift
//  pi-manager-viewer
//
//  Created by David Márquez Delgado on 29/11/2019.
//  Copyright © 2019 David Márquez Delgado. All rights reserved.
//

import UIKit

class CircleViewController: UIViewController {

    @IBOutlet var myMainView: UIView!
    @IBOutlet weak var myCircleView: PercentageCircle!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        myMainView.backgroundColor = UiConstants.DARK_GREY

        myCircleView.drawCircleWith(usedPercentage: 66.0)

    }
}


