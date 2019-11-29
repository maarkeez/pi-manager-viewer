//
//  ViewController.swift
//  pi-manager-viewer
//
//  Created by David Márquez Delgado on 17/11/2019.
//  Copyright © 2019 David Márquez Delgado. All rights reserved.
//

import UIKit

class MainController: UIViewController {

    @IBOutlet var myMainView: UIView!
    @IBOutlet weak var myTempLabel: UILabel!
    @IBOutlet weak var myTempView: UIView!
    @IBOutlet weak var myTempLabelStr: UILabel!
    
    @IBOutlet weak var myCpuView: UIView!
    @IBOutlet weak var myCpuLabelStr: UILabel!
    @IBOutlet weak var myCpuLabel: UILabel!
    
    @IBOutlet weak var myMemoryView: UIView!
    @IBOutlet weak var myMemoryLabelStr: UILabel!
    @IBOutlet weak var myMemoryLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Main
        self.myMainView.backgroundColor = UiConstants.DARK_GREY
        
        // Temperature
        decorateSection(mainView: myTempView, labelStr: myTempLabelStr, label: myTempLabel)

        // Cpu
        decorateSection(mainView: myCpuView, labelStr: myCpuLabelStr, label: myCpuLabel)

        // Memory
        decorateSection(mainView: myMemoryView, labelStr: myMemoryLabelStr, label: myMemoryLabel)
        
        updateCpu()
        updateTemperature()
        updateMemory()
    }
    
    private func decorateSection(mainView: UIView, labelStr: UILabel, label: UILabel){
        mainView.layer.cornerRadius = 3
        mainView.backgroundColor = UiConstants.SOFT_GREY
        
        labelStr.textColor = UiConstants.SOFT_YELLOW
        
        label.textColor = UiConstants.BLUE
        label.generateShadow()
    }

    private func updateTemperature() {
        
        TemperatureService.singleton().readTemperature().done { degree in
            self.myTempLabel.text = "\(degree.getDegree()) ºC"
        }.catch{error in
            self.myTempLabel.text = "Could not load temperature"
        }
    }
    
    private func updateCpu() {
        
        CpuUsageService.singleton().readCpuUsage().done { cpu in
                let free = String(format:"%.2f", cpu.getTotal() - cpu.getUsed() )
                self.myCpuLabel.text = "Used: \(cpu.getUsed()) %\nFree: \(free) %"
            }.catch{ error in
                self.myCpuLabel.text = "Could not load cpu"
        }
    }
    
    private func updateMemory() {
        
        MemoryUsageService.singleton().readMemoryUsage().done { memory in
                let free = String(format:"%.2f", memory.getTotal() - memory.getUsed() )
                self.myMemoryLabel.text = "Used: \(memory.getUsed()) %\nFree: \(free) %"
            }.catch{error in
                self.myMemoryLabel.text = "Could not load memory"
        }
    }

}
