//
//  MyToastView.swift
//  ToastCollectionViewCell_Example
//
//  Created by Oscar Götting on 6/14/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

class MyToastView: UIView {
    
    var title: String = "" {
        didSet {
            self.label.text = title
        }
    }
    
    var label: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.light)
        label.textAlignment = .center
        label.textColor = UIColor.white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func doSomething() {
        // Do something
    }
    
    func setup() {
        self.clipsToBounds = true
        self.layer.cornerRadius = 10.0
        self.backgroundColor = UIColor(red: 215, green: 215, blue: 215, a: 0.8)
        self.label.frame = self.frame
        self.addSubview(self.label)
    }
}
