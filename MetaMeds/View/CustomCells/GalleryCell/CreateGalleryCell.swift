//
//  CreateGalleryCell.swift
//  Fag
//
//  Created by Smarthermacmini on 31/10/20.
//  Copyright © 2020 Gowtham. All rights reserved.
//

import UIKit

class CreateGalleryCell: UICollectionViewCell {

    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var selected_img: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cancelBtn.setImage(UIImage.init(named: "icons8-macos-close-64")?.maskWithColor(color: UIColor.init(named: "AppColor")!), for: .normal)
    }

}
