//
//  ToastCollectionViewCell.swift
//  Pods-ToastCollectionViewCell_Example
//
//  Created by Oscar Götting on 6/13/18.
//

import Foundation
import UIKit


public protocol ToastCollectionViewCellDelegate {
    func onToastFullyRaised(toast: UIView)
}

open class ToastCollectionViewCell: UICollectionViewCell {
    
    open var delegate: ToastCollectionViewCellDelegate?
    open var componentMaximumHeight: CGFloat = 0.0
    internal var toastView: UIView?
    internal var componentOriginY: CGFloat = 0
    private var maximumPositionReached: Bool = false
    
    open func preRaiseToastView() {
        shouldEnsureComponentIsAtMaxPosition()
    }
    
    func shouldEnsureComponentIsAtMaxPosition() {
        guard let view = self.toastView else {
            return
        }
        view.frame.origin.y = self.componentOriginY - componentMaximumHeight
        if self.maximumPositionReached == false {
            delegate?.onToastFullyRaised(toast: view)
            self.maximumPositionReached = true
        }
    }
    
    func shouldRaiseComponent(with offset: CGFloat) {
        guard let view = self.toastView else {
            return
        }
        view.frame.origin.y = self.componentOriginY - offset
    }
    
    func shouldDropComponent(with offset: CGFloat) {
        guard let view = self.toastView else {
            return
        }
        view.frame.origin.y = (self.componentOriginY - componentMaximumHeight) + offset
    }
    
    open func addToastView(view: UIView, withMaximumHeightPosition: Float) {
        
        self.componentMaximumHeight = CGFloat(withMaximumHeightPosition)
        
        let positionX = (self.bounds.width / 2) - (view.frame.width / 2)
        let positionY = self.bounds.height
        
        view.frame = CGRect(x: positionX, y: positionY, width: view.frame.width, height: view.frame.height)
        
        self.componentOriginY = positionY
        self.toastView = view
        
        addSubview(view)
    }
    
    override open func prepareForReuse() {
        self.maximumPositionReached = false
        self.toastView?.removeFromSuperview()
        self.toastView = nil
        self.delegate = nil
        super.prepareForReuse()
    }
}
