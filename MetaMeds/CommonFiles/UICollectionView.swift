//
//  UICollectionView.swift
//  HurryBunny
//
//  Created by Smarthermacmini on 08/08/20.
//  Copyright © 2020 Smarthermacmini. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView
{
    func isValid(type:Int,indexPath: IndexPath)
    {
        guard indexPath.section < numberOfSections,
            indexPath.row < numberOfItems(inSection: indexPath.section)
            else { print("************** ")
                return }
        if type == 1
        {
            self.reloadItems(at: [indexPath])
        }
        else if type == 2
        {
            self.deleteItems(at: [indexPath])
        }
        else if type == 3
        {
            self.reloadData()
        }
    }
    
    func isValidIndex(indexPath: IndexPath) -> Bool {
      guard indexPath.section < numberOfSections,
         indexPath.row < numberOfItems(inSection: indexPath.section)
        else { print("********* ")
          return false }
      return true
    }
    
}
