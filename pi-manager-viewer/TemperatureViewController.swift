//
//  ViewController.swift
//  pi-manager-viewer
//
//  Created by David Márquez Delgado on 17/11/2019.
//  Copyright © 2019 David Márquez Delgado. All rights reserved.
//

import UIKit

class TemperatureViewController: UIViewController {

    @IBOutlet weak var myTempLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateTemperature()
    }

    private func updateTemperature(){
        
        TemperatureService.singleton().readTemperature().done { degree in
            self.myTempLabel.text = "\(degree.getDegree()) ºC"
        }.catch{error in
            self.myTempLabel.text = "Could not load temperature"
        }
    }

}

