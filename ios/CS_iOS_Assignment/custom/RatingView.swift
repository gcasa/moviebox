//
//  RatingView.swift
//  CS_iOS_Assignment
//
//  Copyright © 2019 Backbase. All rights reserved.
//

import UIKit

class RatingView: UIView {

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
        var color : UIColor!
   
        if (value > 0.50 && value <= 1.0)
        {
            color = UIColor.green
        }
        if (value <= 0.50)
        {
            color = UIColor.yellow
        }
        
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
        var endAngle = startAngle + 2 * .pi * value
        
        // move to the center of the pie chart
        ctx?.move(to: viewCenter)
        
        // add arc from the center for each segment (anticlockwise is specified for the arc, but as the view flips the context, it will produce a clockwise arc)
        ctx?.addArc(center: viewCenter, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        
        // fill segment
        ctx?.fillPath()
        
        // move to the center of the pie chart
        ctx?.move(to: viewCenter)
        ctx?.setFillColor(self.backgroundColor!.cgColor)
        
        // add arc from the center for each segment (anticlockwise is specified for the arc, but as the view flips the context, it will produce a clockwise arc)
        // update the end angle of the segment
        endAngle = startAngle + 2 * .pi * 100
        ctx?.addArc(center: viewCenter, radius: radius * 0.75, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        ctx?.fillPath()
        
        // Draw the percentage in the middle of the view.
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let attrs = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 16)!, NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.foregroundColor: UIColor.white]
        let rect = CGRect(x: viewCenter.x - 26, y: viewCenter.y - 12, width: 50, height: 25)
        let string = String(format: "%3.0f", (value * 100))
        string.draw(with: rect, options: .usesLineFragmentOrigin, attributes: attrs, context: nil)
        
        // update starting angle of the next segment to the ending angle of this segment
        startAngle = endAngle
    }
}
