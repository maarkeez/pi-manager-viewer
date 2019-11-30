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
  
    @IBOutlet weak var myCpuView: PercentageCircle!
    @IBOutlet weak var myMemoryView: PercentageCircle!
    @IBOutlet weak var goToFilesBtn: UIBarButtonItem!
    
    var timer: Timer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Navigation controler
        navigationController?.navigationBar.barTintColor = UiConstants.SOFT_PINK_NAVIGATION
        goToFilesBtn.tintColor = UiConstants.SOFT_YELLOW
        
        // Main
        self.myMainView.backgroundColor = UiConstants.DARK_GREY
        
        // Temperature
        decorateSection(mainView: myTempView, labelStr: myTempLabelStr, label: myTempLabel)

        myCpuView.setTitle("CPU")
        myMemoryView.setTitle("Memory")
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Start updating system metrics
        updateSystemMetrics()
        timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { _ in
            self.updateSystemMetrics()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        timer?.invalidate()
    }
    
    private func updateSystemMetrics() {
        updateCpu()
        updateTemperature()
        updateMemory()
    }
    
    private func decorateSection(mainView: UIView, labelStr: UILabel, label: UILabel){
        mainView.layer.cornerRadius = 5
        mainView.backgroundColor = UiConstants.SOFT_GREY
        
        labelStr.textColor = UiConstants.SOFT_YELLOW
        
        label.textColor = UiConstants.BLUE
        label.generateShadow()
    }

    private func updateTemperature() {
        
        TemperatureService.singleton().readTemperature().done { degree in
            self.myTempLabel.text = "\(degree.getDegree()) ºC"
        }.catch{error in
            self.myTempLabel.text = "0 ºC"
        }
    }
    
    private func updateCpu() {
        
        CpuUsageService.singleton().readCpuUsage().done { cpu in
            self.myCpuView.drawCircleWith(usedPercentage: cpu.getUsed())
        }.catch{error in
            print("could not read cpu usage")
        }
    }
    
    private func updateMemory() {
        
        MemoryUsageService.singleton().readMemoryUsage().done { memory in
                self.myMemoryView.drawCircleWith(usedPercentage: memory.getUsed())
            }.catch{error in
                print("could not read memory usage")
        }
    }

}
