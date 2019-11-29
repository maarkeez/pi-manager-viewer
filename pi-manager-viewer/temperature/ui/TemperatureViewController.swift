//
//  ViewController.swift
//  pi-manager-viewer
//
//  Created by David Márquez Delgado on 17/11/2019.
//  Copyright © 2019 David Márquez Delgado. All rights reserved.
//

import UIKit

class TemperatureViewController: UIViewController {

    @IBOutlet var myMainView: UIView!
    @IBOutlet weak var myTempLabel: UILabel!
    @IBOutlet weak var myTempView: UIView!
    @IBOutlet weak var myTempLabelStr: UILabel!
    
    @IBOutlet weak var myCpuView: UIView!
    @IBOutlet weak var myCpuLabelStr: UILabel!
    @IBOutlet weak var myCpuLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Main
        self.myMainView.backgroundColor = UiConstants.DARK_GREY
        
        // Temperature
        self.myTempView.layer.cornerRadius = 3
        self.myTempView.backgroundColor = UiConstants.SOFT_GREY
        
        self.myTempLabelStr.textColor = UiConstants.SOFT_YELLOW

        self.myTempLabel.textColor = UiConstants.BLUE
        self.myTempLabel.generateShadow()
        

        // Cpu
        self.myCpuView.layer.cornerRadius = 3
        self.myCpuView.backgroundColor = UiConstants.SOFT_GREY
        
        self.myCpuLabelStr.textColor = UiConstants.SOFT_YELLOW
        
        self.myCpuLabel.textColor = UiConstants.BLUE
        self.myCpuLabel.generateShadow()


        updateTemperature()
        updateCpu()
    }

    private func updateTemperature(){
        
        TemperatureService.singleton().readTemperature().done { degree in
            self.myTempLabel.text = "\(degree.getDegree()) ºC"
        }.catch{error in
            self.myTempLabel.text = "Could not load temperature"
        }
    }
    
    private func updateCpu(){
        
        CpuUsageService.singleton().readCpuUsage().done { cpu in
            let free = String(format:"%.2f", cpu.getTotal() - cpu.getUsed() )
            self.myCpuLabel.text = "Used: \(cpu.getUsed()) %\nFree: \(free) %"
        }.catch{error in
                self.myCpuLabel.text = "Could not load cpu"
        }
    }

}
