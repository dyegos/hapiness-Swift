//
//  smileness.swift
//  hapiness
//
//  Created by iPicnic Digital on 12/5/15.
//  Copyright © 2015 Dyego Silva. All rights reserved.
//

import UIKit

protocol faceViewDataSource: class
{
    func smilenessForFaceView(sender: FaceView) ->Double?
}

@IBDesignable
class FaceView: UIView
{
    var lineWidth:CGFloat = 3 { didSet { setNeedsDisplay() } }
    var color:UIColor = UIColor.blackColor() { didSet { setNeedsDisplay() } }
    var scale:CGFloat = 0.9 { didSet { setNeedsDisplay() } }
    
    var faceCenter:CGPoint { return convertPoint(center, fromView: superview) }
    var faceRadius:CGFloat { return (min(bounds.size.width, bounds.size.height) * 0.5) * scale }
    
    weak var dataSource: faceViewDataSource?
    
    private struct Scaling
    {
        static let FaceRadiusToEyeRadiusRatio: CGFloat = 10
        static let FaceRadiusToEyeOffsetRatio: CGFloat = 3
        static let FaceRadiusToEyeSeparationRatio: CGFloat = 1.5
        static let FaceRadiusToMouthWidthRatio: CGFloat = 1
        static let FaceRadiusToMouthHeghtRatio: CGFloat = 3
        static let FaceRadiusToMouthOffsetRatio: CGFloat = 3
    }
    
    private enum Eye { case Left, Right }
    
    private func bezierPathForEye(whichEye : Eye) -> UIBezierPath
    {
        let eyeRadius = faceRadius / Scaling.FaceRadiusToEyeRadiusRatio
        let eyeVerticalOffset = faceRadius / Scaling.FaceRadiusToEyeOffsetRatio
        let eyeHorizontalSeparation = faceRadius / Scaling.FaceRadiusToEyeSeparationRatio
        
        var eyeCenter = faceCenter
        eyeCenter.y -= eyeVerticalOffset
        switch whichEye
        {
        case .Left: eyeCenter.x -= eyeHorizontalSeparation * 0.5
        case .Right: eyeCenter.x += eyeHorizontalSeparation * 0.5
        }
        
        let path = UIBezierPath(arcCenter: eyeCenter, radius: eyeRadius, startAngle: 0, endAngle: CGFloat(2*M_PI), clockwise: true)
        path.lineWidth = lineWidth
        
        return path
    }
    
    private func bezierPathForSmile(fractionOfSmile: Double) -> UIBezierPath
    {
        let mouthWidth = faceRadius / Scaling.FaceRadiusToMouthWidthRatio
        let mouthHeight = faceRadius / Scaling.FaceRadiusToMouthHeghtRatio
        let mouthVerticalOffset = faceRadius / Scaling.FaceRadiusToMouthOffsetRatio
        
        let smileHeight = CGFloat(max(min(fractionOfSmile, 1), -1)) * mouthHeight
        
        let start = CGPoint(x: faceCenter.x - mouthWidth * 0.5, y: faceCenter.y + mouthVerticalOffset)
        let end = CGPoint(x: start.x + mouthWidth, y: start.y)
        let cp1 = CGPoint(x: start.x + mouthWidth / 3, y: start.y + smileHeight)
        let cp2 = CGPoint(x: end.x - mouthWidth / 3, y: cp1.y)
        
        let path = UIBezierPath()
        path.moveToPoint(start)
        path.addCurveToPoint(end, controlPoint1: cp1, controlPoint2: cp2)
        path.lineWidth = lineWidth
        
        return path
    }
    
    override func drawRect(rect: CGRect)
    {
        let facePath = UIBezierPath(arcCenter: faceCenter, radius: faceRadius, startAngle: 0, endAngle: CGFloat(2*M_PI), clockwise: true)
        facePath.lineWidth = lineWidth
        color.set()
        facePath.stroke()
        
        bezierPathForEye(.Left).stroke()
        bezierPathForEye(.Right).stroke()
        let smileness = dataSource?.smilenessForFaceView(self) ?? 0.0
        bezierPathForSmile(smileness).stroke()
    }
}
