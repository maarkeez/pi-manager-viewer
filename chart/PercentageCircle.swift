//
//  PercentageCircle.swift
//  pi-manager-viewer
//
//  Created by David Márquez Delgado on 30/11/2019.
//  Copyright © 2019 David Márquez Delgado. All rights reserved.
//

import UIKit

class PercentageCircle: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var myUsedLabel: UILabel!
    @IBOutlet weak var myFreeLabel: UILabel!
    @IBOutlet weak var myTitle: UILabel!
    
    // MARK - Override's to be a reutilizable UIView
    let nibName = "PercentageCircle"
    var firstSemiCircleLayer   = CAShapeLayer()
    var secondSemiCircleLayer   = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        let bundle = Bundle.init(for: self.classForCoder)
        bundle.loadNibNamed(nibName, owner: self, options: nil)
        contentView.frame = bounds
        self.addSubview(contentView)
    }
    
    override func draw(_ rect: CGRect) {
        contentView.backgroundColor = UiConstants.SOFT_GREY
        myUsedLabel.textColor = UiConstants.SOFT_PINK
        myFreeLabel.textColor = UiConstants.SOFT_YELLOW
        myTitle.textColor = UiConstants.SOFT_YELLOW
        self.layer.addSublayer(firstSemiCircleLayer)
        self.layer.addSublayer(secondSemiCircleLayer)
    }
 
    // Allows change the upper title
    public func setTitle(_ title: String){
        myTitle.text = title
    }
    
    // Draws a circle, only can be invoked once.
    // it does not render twice the circle
    public func drawCircleWith(usedPercentage: Double) {
        
        if (usedPercentage > 100.0) {
            
            myUsedLabel.text = String(format:"USED: %.2f", usedPercentage )
            myFreeLabel.text = ""
            
            drawCircle(UiConstants.SOFT_PINK, from: 0.0, to: 100.0, in: firstSemiCircleLayer)
            
        } else {
            
            myUsedLabel.text = String(format:"USED: %.2f", usedPercentage )
            myFreeLabel.text = String(format:"FREE: %.2f", 100.0 - usedPercentage )
            
            drawCircle(UiConstants.SOFT_PINK, from: 0.5, to: usedPercentage - 0.5,  in: firstSemiCircleLayer)
            drawCircle(UiConstants.SOFT_YELLOW, from: usedPercentage + 0.5, to: 99.5, in: secondSemiCircleLayer)
        }
        
    }
    
    
    private func drawCircle(_ color: UIColor, from: Double, to: Double, in semiCircleLayer: CAShapeLayer) {

        let completeCircle = CGFloat(Double.pi*2)
        let start = completeCircle * CGFloat(from) / 100
        let end = completeCircle * CGFloat(to) / 100
        
        let lineWith = CGFloat(integerLiteral: 12)
        
        let center = CGPoint (x: self.frame.size.width / 2 , y: self.frame.size.height / 2 )
        let circleRadius = (self.frame.size.width / 2) - lineWith * 2
        let circlePath = UIBezierPath(arcCenter: center, radius: circleRadius, startAngle: start - CGFloat(Double.pi/2) , endAngle: end - CGFloat(Double.pi/2), clockwise: true)
        
        
        semiCircleLayer.path = circlePath.cgPath
        semiCircleLayer.strokeColor = color.cgColor
        semiCircleLayer.fillColor = UIColor(white: 1, alpha: 0.0).cgColor
        semiCircleLayer.lineWidth = lineWith
        semiCircleLayer.strokeStart = 0
        semiCircleLayer.strokeEnd  = 1
        
        
    }
}
