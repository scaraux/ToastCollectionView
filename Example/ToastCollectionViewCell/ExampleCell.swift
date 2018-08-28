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
    
    var toast = MyToastView(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
    
    func configureCell(with data: DummyData) {
        self.delegate = self
        self.backgroundColor = data.color!
        self.toast.title = data.colorName!
    }

    override func toastViewForCell() -> UIView? {
        return self.toast
    }
}

extension ExampleCell: ToastCollectionViewCellDelegate {
    func onToastFullyRaised(toast: UIView) {
        let view = toast as! MyToastView
        view.doSomething()
    }
}
