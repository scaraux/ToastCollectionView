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

class ExampleCell: ToastCollectionViewCell {
    
    var toastView = MyToastView(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
    
    func configureCell(with object: DummyData) {
        self.backgroundColor = object.color!
        self.toastView.title = object.colorName!
        self.delegate = self
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        addToastView(view: self.toastView, withMaximumHeightPosition: 75.0)
    }
}

extension ExampleCell: ToastCollectionViewCellDelegate {
    func onToastFullyRaised(toast: UIView) {
        let toast = toast as! MyToastView
        toast.doSomething()
    }
}
