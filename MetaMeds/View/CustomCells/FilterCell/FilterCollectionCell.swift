//
//  FilterCollectionCell.swift
//  MetaMeds
//
//  Created by Ajeeth Kumar on 09/10/23.
//

import UIKit

class FilterCollectionCell: UICollectionViewCell {

    @IBOutlet weak var bg_layout: UIView!
    
    @IBOutlet weak var name_lbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.bg_layout.layer.cornerRadius = 10
        self.bg_layout.layer.masksToBounds = true
    }
    func CellValues(dict: BloodGroupDataObj)
    {
        name_lbl.text = dict.name
    }
    func CellValues1(dict: BloodGroupDataObj)
    {
        name_lbl.text = dict.name
    }
}
