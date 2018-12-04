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
    internal var toastView: UIView?
    private var maximumPositionReached: Bool = false
    
    private var initialToastViewWidth: CGFloat?
    private var toastTop: NSLayoutConstraint?
    private var toastWidth: NSLayoutConstraint?

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func addToastView(view: UIView) {
        addSubview(view)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        view.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = true
        
        self.toastTop = view.topAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        self.toastTop!.isActive = true
        self.initialToastViewWidth = view.frame.width
        self.toastWidth = view.widthAnchor.constraint(equalToConstant: self.initialToastViewWidth!)
        self.toastWidth!.isActive = true
        self.toastView = view
    }
    
    func setup() {
        if let view = toastViewForCell() {
            addToastView(view: view)
        }
    }
    
    open func toastViewForCell() -> UIView? {
        return nil
    }
    
    open func widthForExpandedToastView() -> CGFloat? {
        return nil
    }
    
    open func preRaiseToastView(toPosition: CGFloat) {
        guard let view = self.toastView else {
            return
        }
        self.toastTop?.constant = -1 * toPosition
        delegate?.onToastFullyRaised(toast: view)
        self.maximumPositionReached = true
    }
    
    func shouldEnsureComponentIsAtMaxPosition(maximumPosition: CGFloat) {
        guard let view = self.toastView else {
            return
        }
        self.toastTop?.constant = -1 * maximumPosition

        if self.maximumPositionReached == false {
            if let expandWidth = widthForExpandedToastView() {
                UIView.animate(withDuration: 0.4, animations: {
                    self.toastWidth?.constant = expandWidth
                    self.layoutIfNeeded()
                })
            }
            delegate?.onToastFullyRaised(toast: view)
            self.maximumPositionReached = true
        }
    }
    
    func shouldRaiseComponent(with offset: CGFloat, maxPosition: CGFloat) {
        self.toastTop?.constant = -1 * offset
    }
    
    func shouldDropComponent(with offset: CGFloat, maxPosition: CGFloat) {
        self.toastTop?.constant = (-1 * maxPosition) + offset
    }
    
    override open func prepareForReuse() {
        self.maximumPositionReached = false
        if self.toastView != nil {
            self.toastWidth!.constant = self.initialToastViewWidth!
        }
        super.prepareForReuse()
    }
}
