//
//  UITableView.swift
//  HurryBunny
//
//  Created by Smarthermacmini on 08/08/20.
//  Copyright © 2020 Smarthermacmini. All rights reserved.
//

import Foundation
import UIKit

extension UITableView
{
    func scrollToBottom()
    {
        DispatchQueue.main.async
        {
            let indexPath = IndexPath(
                row: self.numberOfRows(inSection:  self.numberOfSections - 1) - 1,
                section: self.numberOfSections - 1)
            self.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    func scrollToTop()
    {
        DispatchQueue.main.async
        {
            let indexPath = IndexPath(row: 0, section: 0)
            self.scrollToRow(at: indexPath, at: .top, animated: false)
        }
    }
    
    func isValid(type:Int,indexPath: IndexPath)
    {
        guard indexPath.section < numberOfSections,
            indexPath.row < numberOfRows(inSection: indexPath.section)
            else { print("************** ")
                return }
        if type == 1
        {
            self.reloadRows(at: [indexPath], with: .none)
        }
        else if type == 2
        {
            self.deleteRows(at: [indexPath], with: .none)
        }
        else if type == 3
        {
            self.reloadData()
        }
    }
    
    func isValidIndex(indexPath: IndexPath) -> Bool {
      guard indexPath.section < numberOfSections,
         indexPath.row < numberOfRows(inSection: indexPath.section)
        else { print("********* ")
          return false }
      return true
    }
    
}
