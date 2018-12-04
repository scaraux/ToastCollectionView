//
//  UICollectionViewDelegateProxy.swift
//  Pods-ToastCollectionView_Example
//
//  Created by Oscar Götting on 12/3/18.
//

import Foundation

class UICollectionViewDelegateProxy: NSObject,  UICollectionViewDelegate {
    
    weak var _userDelegate:  UICollectionViewDelegate?
    weak var _selfDelegate:  UICollectionViewDelegate?
    
    override func responds(to aSelector: Selector!) -> Bool {
        return super.responds(to: aSelector) || _userDelegate?.responds(to: aSelector) == true
    }
    
    override func forwardingTarget(for aSelector: Selector!) -> Any? {
        
        if _userDelegate?.responds(to: aSelector) == true {
            return _userDelegate
        }
        else {
            return super.forwardingTarget(for: aSelector)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        _selfDelegate?.scrollViewDidScroll?(scrollView)
        _userDelegate?.scrollViewDidScroll?(scrollView)
    }
}
