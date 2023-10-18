//
//  CollectionViewLayout.swift
//  SmartSuperMarket
//
//  Created by Bala Mac on 11/08/18.
//  Copyright © 2018 Smarther. All rights reserved.
//

import Foundation
import UIKit

class CollectionViewLayout: UICollectionViewFlowLayout {
    
    var numberOfColumns: CGFloat?
    var Height: CGFloat?
    
    override init() {
        super.init()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }
    
    override var itemSize: CGSize {
        set
        {
        }
        get
        {
            let itemWidth = self.collectionView!.frame.width / (numberOfColumns ?? 0)
            
            return CGSize(width: itemWidth, height: Height ?? 0)
        }
    }
    
    func setupLayout()
    {
        minimumInteritemSpacing = 2
        minimumLineSpacing = 2
        scrollDirection = .vertical
    }
}

