//
//  ToastCollectionViewCell.swift
//  Pods-ToastCollectionViewCell_Example
//
//  Created by Oscar Götting on 6/13/18.
//

import Foundation
import UIKit

open class ToastCollectionViewCell: UICollectionViewCell {
    
    open var component: UIView?
    open var componentOriginY: CGFloat = 0
    
    open func preRaiseComponent() {
        shouldEnsureComponentIsAtMaxPosition()
    }
    
    func shouldEnsureComponentIsAtMaxPosition() {
        guard let component = self.component else {
            return
        }
        
        component.frame.origin.y = self.componentOriginY - 75.0
        //        if component.expanded == false {
        //            component.expand()
        //        }
    }
    
    func shouldRaiseComponent(with offset: CGFloat) {
        guard let component = self.component else {
            return
        }
        component.frame.origin.y = self.componentOriginY - offset
    }
    
    func shouldDropComponent(with offset: CGFloat) {
        guard let component = self.component else {
            return
        }
        component.frame.origin.y = (self.componentOriginY - 75.0) + offset
    }
    
    open func addComponent(view: UIView) {
        
        let positionX = (self.bounds.width / 2) - (view.frame.width / 2)
        let positionY = self.bounds.height
        
        view.frame = CGRect(x: positionX, y: positionY, width: view.frame.width, height: view.frame.height)
        
        self.componentOriginY = positionY
        self.component = view
        
        addSubview(view)
    }
    
    override open func prepareForReuse() {
        self.component?.removeFromSuperview()
        //        self.component?.expanded = false
        super.prepareForReuse()
    }
}
