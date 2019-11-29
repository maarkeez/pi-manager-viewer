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
    @IBOutlet weak var myCircleView: UIView!
    @IBOutlet weak var myUsedLabel: UILabel!
    @IBOutlet weak var myFreeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        myMainView.backgroundColor = UiConstants.DARK_GREY
        myCircleView.backgroundColor = UiConstants.SOFT_GREY
        //Circle Points
        
        myUsedLabel.textColor = UiConstants.SOFT_PINK
        myFreeLabel.textColor = UiConstants.SOFT_YELLOW
        
        drawCircleWith(usedPercentage: 66.0)

        

        // Do any additional setup after loading the view.
    }
    
    private func drawCircleWith(usedPercentage: Double) {
        
        if (usedPercentage > 100.0) {
            
            myUsedLabel.text = String(format:"USED: %.2f", usedPercentage )
            myFreeLabel.text = ""
            
            drawCircle(UiConstants.SOFT_PINK, from: 0.0, to: 100.0)
            
        } else {

            myUsedLabel.text = String(format:"USED: %.2f", usedPercentage )
            myFreeLabel.text = String(format:"FREE: %.2f", 100.0 - usedPercentage )
            
            drawCircle(UiConstants.SOFT_PINK, from: 0.5, to: usedPercentage - 0.5)
            drawCircle(UiConstants.SOFT_YELLOW, from: usedPercentage + 0.5, to: 99.5)
        }
        
    }

    
    private func drawCircle(_ color: UIColor, from: Double, to: Double) {
        
        let completeCircle = CGFloat(Double.pi*2)
        let start = completeCircle * CGFloat(from) / 100
        let end = completeCircle * CGFloat(to) / 100

        let lineWith = CGFloat(integerLiteral: 18)
        let semiCircleLayer   = CAShapeLayer()
        let center = CGPoint (x: myCircleView.frame.size.width / 2 , y: myCircleView.frame.size.height / 2)
        let circleRadius = (myCircleView.frame.size.width / 2) - lineWith * 2
        let circlePath = UIBezierPath(arcCenter: center, radius: circleRadius, startAngle: start - CGFloat(Double.pi/2) , endAngle: end - CGFloat(Double.pi/2), clockwise: true)
        
        
        semiCircleLayer.path = circlePath.cgPath
        semiCircleLayer.strokeColor = color.cgColor
        semiCircleLayer.fillColor = UIColor(white: 1, alpha: 0.0).cgColor
        semiCircleLayer.lineWidth = lineWith
        semiCircleLayer.strokeStart = 0
        semiCircleLayer.strokeEnd  = 1
        
        myCircleView.layer.addSublayer(semiCircleLayer)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


