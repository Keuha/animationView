//
//  ViewController.swift
//  Bouncy
//
//  Created by Franck Petriz on 21/02/2019.
//  Copyright © 2019 Franck Petriz. All rights reserved.
//

import UIKit
import CoreGraphics

class ViewController: UIViewController {

    
    let blackView = BlackView(frame: CGRect(x: 0, y: 0, width: 80, height: 80 ))
    let buttonBackground = UIButton(type: UIButton.ButtonType.custom)
    var initialFrame : CGRect = CGRect.zero
    var initialDistance : CGFloat = 0
    var initialDistanceX : CGFloat = 0
    var initialDistanceY : CGFloat = 0
    var oldWidth: CGFloat = 0
    var oldHeight: CGFloat = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDisplay()
        setupGesture()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    private func setupDisplay() {
        view.addSubview(blackView)
        blackView.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        blackView.translatesAutoresizingMaskIntoConstraints = true
        blackView.center = self.view.center
    }
    
    private func setupGesture() {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(self.panGesture(_:)))
        
        blackView.addGestureRecognizer(pan)
//        blackView.addTarget(target: self,withSelector: #selector(self.innerWubWub(_:)), forState: .touchDown)
        blackView.addTarget(target: self,withSelector: #selector(self.outterWubWub(_:)), forState: .touchUpInside)
    }
    
    @objc private func panGesture(_ panHandler:UIPanGestureRecognizer) {
        let touchLocation = panHandler.location(in: self.view)
        switch panHandler.state {
        case .began:
            initialFrame = blackView.frame;
            initialDistance = distance(blackView.center, touchLocation);
            initialDistanceX = blackView.frame.origin.x.distance(to: touchLocation.x)
            initialDistanceY = blackView.frame.origin.y.distance(to: touchLocation.y)
        case .changed:
            var newWidth : CGFloat = 0
            var newHeight : CGFloat = 0
            let distanceX = initialFrame.origin.x.distance(to: touchLocation.x)
            let distanceY = initialFrame.origin.y.distance(to: touchLocation.y)
            

            var oldHeight = blackView.frame.height
            var oldWidth = blackView.frame.width
            
            newWidth = oldWidth + (distanceX - initialDistanceX)
            newHeight = oldHeight + (distanceY - initialDistanceY)
            var Y = ((oldHeight * (newHeight / oldHeight)) / 2 * oldHeight / newHeight) - initialFrame.height / 2
            var X = ((oldWidth * (newWidth / oldWidth))  / 2 * oldWidth / newWidth) - initialFrame.width / 2

            if newWidth < 0 {
                X = newWidth
                newWidth = abs(newWidth)
                oldWidth = abs(oldWidth)
            }
            if newHeight < 0 {
                Y = newHeight
                newHeight = abs(newHeight)
                oldHeight = abs(oldHeight)
            }
            print("RATIO IS \(X / newWidth)")
            print("RATIO IS \(Y / newHeight)")
            print("new width : \(newWidth) new height : \(newHeight)")
            print("old width : \(oldWidth) old height : \(oldHeight)")
            print("new X : \(X), Y : \(Y)")
            blackView.transform = CGAffineTransform(scaleX: newWidth / oldWidth , y: newHeight / oldHeight )
            blackView.transform.tx = X
            blackView.transform.ty = Y
          
            break
        case .ended:
            animateBackToOrigin(blackView)
        default:
            break
        }
    }
    
    
    private func animateBackToOrigin(_ view : UIView) {
        
        let first = UIViewPropertyAnimator(duration: 0.3, curve: .easeOut, animations: {
            view.transform = CGAffineTransform(scaleX: 0.90, y: 0.90)
        })
        let second = UIViewPropertyAnimator(duration: 0.2, curve: .easeIn, animations: {
            view.transform = CGAffineTransform.identity
        })
        first.addCompletion {_ in second.startAnimation() }
        first.startAnimation()
        
    }
    
    @objc private func innerWubWub(_ btn: UIButton) {
        
//        guard let view = btn.superview else { return }
//            let first = UIViewPropertyAnimator(duration: 0.1, curve: .easeOut, animations: {
//                view.transform = CGAffineTransform(scaleX: 0.70, y: 0.70)
//                view.layer.cornerRadius = view.layer.cornerRadius * 2
//            })
//            let second = UIViewPropertyAnimator(duration: 0.2, curve: .easeIn, animations: {
//               view.transform = CGAffineTransform(scaleX: 0.90, y: 0.90)
//                view.layer.cornerRadius = view.layer.cornerRadius / 2
//            })
//            first.addCompletion {_ in second.startAnimation() }
//            first.startAnimation()
    }
    
    @objc private func outterWubWub(_ btn: UIButton) {
        guard let view = btn.superview else { return }
            let first = UIViewPropertyAnimator(duration: 0.2, curve: .easeOut, animations: {
                view.transform = CGAffineTransform(scaleX: 1.20, y: 1.20)
                view.layer.cornerRadius /= 2
            })
            let second = UIViewPropertyAnimator(duration: 0.2, curve: .easeIn, animations: {
                view.transform = CGAffineTransform.identity
                view.layer.cornerRadius *= 2
            })
        
            first.addCompletion {_ in second.startAnimation() }
            first.startAnimation()
    }
    
    func distance(_ a: CGPoint, _ b: CGPoint) -> CGFloat {
        let xDist = a.x - b.x
        let yDist = a.y - b.y
        return CGFloat(sqrt(xDist * xDist + yDist * yDist))
    }
}

