//
//  RoundedTagView.swift
//  TinkoffChat
//
//  Created by Michael Nikolaev on 29.09.17.
//  Copyright © 2017 Michael Nikolaev. All rights reserved.
//
import UIKit

class RoundedView: UIView {

    var colorForBezel: UIColor! = UIColor.black
    var colorForFill: UIColor! = UIColor.white

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        let rectangle = CGRect(x: 2, y: 2, width: self.frame.size.width-4, height: self.frame.size.height-4)
        let rectPath = UIBezierPath(roundedRect: rectangle, cornerRadius: 10)
        colorForFill.setFill()
        colorForBezel.setStroke()
        rectPath.lineWidth = 2.8
        rectPath.stroke()
        rectPath.fill()
    }
}
