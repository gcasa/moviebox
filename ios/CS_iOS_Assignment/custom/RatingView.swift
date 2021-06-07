//
//  RatingView.swift
//  CS_iOS_Assignment
//
//  Copyright © 2019 Backbase. All rights reserved.
//

import UIKit

class RatingView: UIView {
    
    var color = UIColor() {
        didSet {
            setNeedsDisplay()
        }
    }
    var value = CGFloat () {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initSubviews()
    }
    
    func initSubviews() {
        self.backgroundColor = UIColor.black
    }
    
    override func draw(_ rect: CGRect) {
        
        // get current context
        let ctx = UIGraphicsGetCurrentContext()
        
        // radius is the half the frame's width or height (whichever is smallest)
        let radius = min(frame.size.width, frame.size.height) * 0.5
        
        // center of the view
        let viewCenter = CGPoint(x: bounds.size.width * 0.5, y: bounds.size.height * 0.5)
        
        // the starting angle is -90 degrees (top of the circle, as the context is flipped). By default, 0 is the right hand side of the circle, with the positive angle being in an anti-clockwise direction (same as a unit circle in maths).
        var startAngle = -CGFloat.pi * 0.5
                
        // set fill color to the segment color
        ctx?.setFillColor(color.cgColor)
        
        // update the end angle of the segment
        let endAngle = startAngle + 2 * .pi * value
        
        // move to the center of the pie chart
        ctx?.move(to: viewCenter)
        
        // add arc from the center for each segment (anticlockwise is specified for the arc, but as the view flips the context, it will produce a clockwise arc)
        ctx?.addArc(center: viewCenter, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        
        // fill segment
        ctx?.fillPath()
        
        // update starting angle of the next segment to the ending angle of this segment
        startAngle = endAngle
    }
}
