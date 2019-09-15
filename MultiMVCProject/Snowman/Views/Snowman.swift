//
//  Snowman.swift
//  MultiMVCProject
//
//  Created by Nadzeya Leanovich on 9/13/19.
//  Copyright © 2019 Nadzeya Leanovich. All rights reserved.
//

import UIKit

@IBDesignable
class Snowman: UIView {
    
    @IBInspectable
    var isEyeOpen: Bool = true {didSet {self.setNeedsDisplay()}}
    
    @IBInspectable
    var isHappy: Bool = true {didSet {self.setNeedsDisplay()}}
    
    var scale: CGFloat = 1.0 { didSet {self.setNeedsDisplay()}}
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private enum Constants {
        static let eyeRadiusToHeadRadius: CGFloat = 8.0
        static let eyeOffsetToHeadRadius: CGFloat = 3.0
        static let bigBallToMedium: CGFloat = 0.7
        static let bigBallToSmall:CGFloat = 0.5
        static let mouthOffsetToHeadRadius: CGFloat = 2.0
        static let mouthWidthToHeadRadius: CGFloat = 2.0
        static let mouthHeightToHeadRadius: CGFloat = 3.0
    }
    
    enum Eye {
        case left, right
    }
    
    var radiusOfBigBall: CGFloat {
        if (bounds.maxX < bounds.maxY) {
            return min(bounds.maxX, bounds.maxY/3) / 2 * scale
        }
        
        return bounds.maxY/6 * scale
    }
    
    var radiusOfMediumBall: CGFloat {
        return radiusOfBigBall * Constants.bigBallToMedium
    }
    
    var radiusOfSmallBall: CGFloat {
        return radiusOfBigBall * Constants.bigBallToSmall
    }
    
    var radiusOfEye: CGFloat {
        return radiusOfSmallBall / Constants.eyeRadiusToHeadRadius
    }
    
    var centerOfBigBall: CGPoint {
        return CGPoint(x: bounds.midX, y: bounds.midY + radiusOfMediumBall + radiusOfBigBall)
    }
    
    var centerOfMediumBall: CGPoint {
        return CGPoint(x: bounds.midX, y: bounds.midY)
    }
    
    var centerOfSmallBall: CGPoint {
        return CGPoint(x: bounds.midX, y: bounds.midY - radiusOfMediumBall - radiusOfSmallBall)
    }
    
    func pathBigBall() -> UIBezierPath {
        return UIBezierPath(arcCenter: centerOfBigBall,
                            radius: radiusOfBigBall,
                            startAngle: 0,
                            endAngle: 2 * CGFloat.pi,
                            clockwise: true)
    }
    
    func pathMediumBall() -> UIBezierPath {
        return UIBezierPath(arcCenter: centerOfMediumBall,
                            radius: radiusOfMediumBall,
                            startAngle: 0,
                            endAngle: 2 * CGFloat.pi,
                            clockwise: true)
    }
    
    func pathSmallBall() -> UIBezierPath {
        return UIBezierPath(arcCenter: centerOfSmallBall,
                            radius: radiusOfSmallBall,
                            startAngle: 0,
                            endAngle: 2 * CGFloat.pi,
                            clockwise: true)
    }
    
    func pathOfEye(_ eye: Eye) -> UIBezierPath {
        func centerOfEye(_ eye: Eye) -> CGPoint {
            let eyeOffSet = radiusOfSmallBall / Constants.eyeOffsetToHeadRadius
            
            return CGPoint(x: eye == Eye.left ? centerOfSmallBall.x - eyeOffSet : centerOfSmallBall.x + eyeOffSet,
                           y: centerOfSmallBall.y - eyeOffSet)
        }
        
        let center = centerOfEye(eye)
        var resultPath = UIBezierPath()
        
        if (isEyeOpen) {
            resultPath = UIBezierPath(arcCenter: center,
                                radius: radiusOfEye,
                                startAngle: 0,
                                endAngle: 2 * CGFloat.pi,
                                clockwise: true)
            return resultPath
        }
        
        resultPath.move(to: CGPoint(x: center.x - radiusOfEye, y: center.y))
        resultPath.addLine(to: CGPoint(x: center.x + radiusOfEye, y: center.y))
        return resultPath
    }
    
    func patchOfMouth() -> UIBezierPath {
        let mouthWidth = radiusOfSmallBall / Constants.mouthWidthToHeadRadius
        let mouthHeight = radiusOfSmallBall / Constants.mouthHeightToHeadRadius
        let mouthOffset = radiusOfSmallBall / Constants.mouthOffsetToHeadRadius
        
        let mouthPath = UIBezierPath()
        mouthPath.move(to: CGPoint(x: centerOfSmallBall.x - mouthWidth / 2, y: centerOfSmallBall.y + mouthOffset))
        
        let controlPointFirst = isHappy ? CGPoint(x: centerOfSmallBall.x - mouthWidth / 4, y: centerOfSmallBall.y + mouthOffset + mouthHeight / 3)
            : CGPoint(x: centerOfSmallBall.x - mouthWidth / 4, y: centerOfSmallBall.y + mouthOffset - mouthHeight / 3)
        
        let controlPointSecond = isHappy ? CGPoint(x: centerOfSmallBall.x + mouthWidth / 4, y: centerOfSmallBall.y + mouthOffset + mouthHeight / 3)
            : CGPoint(x: centerOfSmallBall.x + mouthWidth / 4, y: centerOfSmallBall.y + mouthOffset - mouthHeight / 3)
        
        mouthPath.addCurve(to: CGPoint(x: centerOfSmallBall.x + mouthWidth / 2, y: centerOfSmallBall.y + mouthOffset),
                           controlPoint1: controlPointFirst,
                           controlPoint2: controlPointSecond)
        
        return mouthPath
    }
    
    @objc func adjustScale(handleGestureRecognizer gesture: UIPinchGestureRecognizer) {
        scale = gesture.scale
    }
    
    @objc func changeMood(handleTapRecognizer gesture: UITapGestureRecognizer) {
        isHappy = !isHappy
    }
    
    @objc func closeEyes(handleTapRecognizer gesture: UILongPressGestureRecognizer) {
        isEyeOpen = !isEyeOpen
    }
    
    override func draw(_ rect: CGRect) {
        pathBigBall().stroke()
        pathMediumBall().stroke()
        pathSmallBall().stroke()
        pathOfEye(.left).stroke()
        pathOfEye(.right).stroke()
        patchOfMouth().stroke()
    }
}
