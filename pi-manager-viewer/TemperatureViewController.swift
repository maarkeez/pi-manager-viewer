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
        let url = URL(string: "http://10.10.1.108:8080/api/degree")!
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            print(String(data: data, encoding: .utf8)!)
        }
        task.resume()
        
        
    }
    

}

