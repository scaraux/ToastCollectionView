//
//  ViewController.swift
//  ToastCollectionViewCell
//
//  Created by gottingoscar@gmail.com on 06/13/2018.
//  Copyright (c) 2018 gottingoscar@gmail.com. All rights reserved.
//

import UIKit
import ToastCollectionViewCell

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var delegate = ToastCollectionViewDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate.collectionView = self.collectionView
        self.collectionView.dataSource = self
        self.collectionView.delegate = delegate
        self.collectionView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExampleCell", for: indexPath) as! ExampleCell
        cell.setNeedsLayout()
        cell.layoutIfNeeded()
        
        if indexPath.item == 0 {
            cell.preRaiseComponent()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.bounds.width
        return CGSize(width: width, height: width)
    }
}
