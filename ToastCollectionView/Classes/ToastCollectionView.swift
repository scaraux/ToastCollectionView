//
//  ToastCollectionView.swift
//  Pods-ToastCollectionViewCell_Example
//
//  Created by Oscar Götting on 12/2/18.
//

import Foundation

open class ToastCollectionView: UICollectionView, UICollectionViewDelegate {
    
    open var offsetToComponent: Float = 20.0
    open var maxPositionForComponent: Float = 75.0
    
    private var lastContentOffset: CGFloat = 0.0
    private var delegateProxy = UICollectionViewDelegateProxy()

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        super.delegate = delegateProxy
        self.delegateProxy._selfDelegate = self
    }
    
    public override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        super.delegate = delegateProxy
        self.delegateProxy._selfDelegate = self
    }

    open override var delegate: UICollectionViewDelegate? {
        get {
            return delegateProxy._userDelegate
        }
        set {
            self.delegateProxy._userDelegate = newValue;
            super.delegate = nil
            super.delegate = delegateProxy
        }
    }
    
    private func getOrderedVisibleCellsOfType<T: UICollectionViewCell>(forCellType type: T.Type) -> [UICollectionViewCell] {
        return self.indexPathsForVisibleItems
            .sorted { $0.section < $1.section || $0.row < $1.row }
            .compactMap { self.cellForItem(at: $0) }
            .filter { $0 is T }
    }

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let visibleCells = self.getOrderedVisibleCellsOfType(forCellType: ToastCollectionViewCell.self)
        
        for cellIndex in 0..<visibleCells.count {
            
            let cell = visibleCells[cellIndex] as! ToastCollectionViewCell
            
            guard let indexPath = self.indexPath(for: cell) else {
                return
            }
            guard let cellAttributes = self.layoutAttributesForItem(at: indexPath) else {
                return
            }
            
            let scrollOffset: CGFloat = self.bounds.origin.y
            let cellHeight: CGFloat = cellAttributes.frame.height
            let cellPosition: CGFloat = cellAttributes.frame.origin.y
            let topOffsetToCell: CGFloat = scrollOffset - cellPosition
            
            if cellIndex == 0 {
                let topOffsetToBottomOfCell: Float = -1 * Float(topOffsetToCell - cellHeight)
                // If offset between top of collectionview and bottom of cell is between 0 and thresold
                if 0.0 ... self.maxPositionForComponent + self.offsetToComponent ~= topOffsetToBottomOfCell {
                    // If going up (Finger swipe down)
                    if self.lastContentOffset > scrollView.contentOffset.y {
                        let position = CGFloat(topOffsetToBottomOfCell - self.offsetToComponent)
                        cell.shouldRaiseComponent(with: position, maxPosition: CGFloat(maxPositionForComponent))
                    }
                        // If going down (Finger swipe up)
                    else if self.lastContentOffset < scrollView.contentOffset.y {
                        let position = CGFloat(self.maxPositionForComponent - topOffsetToBottomOfCell + self.offsetToComponent)
                        cell.shouldDropComponent(with: position, maxPosition: CGFloat(maxPositionForComponent))
                    }
                } else if topOffsetToBottomOfCell > self.maxPositionForComponent {
                    cell.shouldEnsureComponentIsAtMaxPosition(maximumPosition: CGFloat(maxPositionForComponent))
                }
            }
            else if cellIndex == visibleCells.count - 1 {
                let viewPortHeight: CGFloat = self.frame.height
                let bottomOffsetToBottomOfCell = -1 * Float(topOffsetToCell + viewPortHeight - cellHeight)
                // If offset between bottom of collectionview and bottom of cell is between 0 and thresold
                if 0.0 ... self.maxPositionForComponent + self.offsetToComponent ~= bottomOffsetToBottomOfCell {
                    // If going up (Finger swipe down)
                    if self.lastContentOffset > scrollView.contentOffset.y {
                        let position = CGFloat(bottomOffsetToBottomOfCell)
                        cell.shouldDropComponent(with: position, maxPosition: CGFloat(maxPositionForComponent))
                    }
                        // If going down (Finger swipe up)
                    else if self.lastContentOffset < scrollView.contentOffset.y {
                        let position = CGFloat(self.maxPositionForComponent - bottomOffsetToBottomOfCell)
                        cell.shouldRaiseComponent(with: position, maxPosition: CGFloat(maxPositionForComponent))
                    }
                } else if bottomOffsetToBottomOfCell < 0.0 {
                    cell.shouldEnsureComponentIsAtMaxPosition(maximumPosition: CGFloat(maxPositionForComponent))
                }
            }
        }
        self.lastContentOffset = scrollView.contentOffset.y
    }
}
