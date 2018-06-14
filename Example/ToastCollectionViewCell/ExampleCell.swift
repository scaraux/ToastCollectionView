//
//  ExampleCell.swift
//  ToastCollectionViewCell_Example
//
//  Created by Oscar Götting on 6/13/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import ToastCollectionViewCell

class ToastComponent: UIView {
    
    var title: String = "" {
        didSet {
            self.label.text = title
        }
    }
    
    var label: UILabel = {
       let label = UILabel(frame: .zero)
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
    
    func setup() {
        self.clipsToBounds = true
        self.layer.cornerRadius = 10.0
        self.backgroundColor = UIColor.lightGray.withAlphaComponent(0.9)
        self.label.frame = self.frame
        self.addSubview(self.label)
    }
}
class ExampleCell: ToastCollectionViewCell {
    
    var toastView = ToastComponent(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
    
    func configureCell(with object: DummyData) {
        self.backgroundColor = object.color!
        self.toastView.title = object.colorName!
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        addToastView(view: self.toastView, withMaximumHeightPosition: 75.0)
    }
}
