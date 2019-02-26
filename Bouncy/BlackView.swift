//
//  blackView.swift
//  Bouncy
//
//  Created by Franck Petriz on 21/02/2019.
//  Copyright © 2019 Franck Petriz. All rights reserved.
//

import Foundation
import UIKit
class BlackView : UIView {
    
    let swiftImageView : UIImageView = {
        var image = UIImageView()
        image.image = UIImage(named: "swift.png")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let backgroundButton : UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.backgroundColor = .clear
        btn.isUserInteractionEnabled = true
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        setupDisplay()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        setupDisplay()
    }
    
    private func setupDisplay() {
        self.layer.cornerRadius = 10
        self.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        
        self.addSubview(backgroundButton)
        backgroundButton.translatesAutoresizingMaskIntoConstraints = false
        [
            NSLayoutConstraint(item: backgroundButton, attribute: .top, relatedBy: .equal , toItem: self, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: backgroundButton, attribute: .bottom, relatedBy: .equal , toItem: self, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: backgroundButton, attribute: .leading, relatedBy: .equal , toItem: self, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: backgroundButton, attribute: .trailing, relatedBy: .equal , toItem: self, attribute: .trailing, multiplier: 1, constant: 0),
        ].forEach { self.addConstraint($0) }
        
        
        self.addSubview(swiftImageView)
        swiftImageView.translatesAutoresizingMaskIntoConstraints = false
        [
        NSLayoutConstraint(item: swiftImageView, attribute: .width, relatedBy: .lessThanOrEqual , toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50),
        NSLayoutConstraint(item: swiftImageView, attribute: .height, relatedBy: .lessThanOrEqual , toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50),
        NSLayoutConstraint(item: swiftImageView, attribute: .centerX, relatedBy: .equal , toItem: self, attribute: .centerX, multiplier: 1, constant: 1),
        NSLayoutConstraint(item: swiftImageView, attribute: .centerY, relatedBy: .equal , toItem: self, attribute: .centerY, multiplier: 1, constant: 1),
        
        ].forEach { self.addConstraint($0) }
    }
    
    func addTarget(target : Any, withSelector selector:Selector, forState state:UIControl.Event) {
        backgroundButton.addTarget(target, action: selector, for: state)
    }
}
