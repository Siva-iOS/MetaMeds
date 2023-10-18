//
//  PaymentTableCell.swift
//  GFA Ecommerce
//
//  Created by Smarthermacmini1 on 27/05/21.
//  Copyright © 2021 Smarthermacmini. All rights reserved.
//

import UIKit

class PaymentTableCell: UITableViewCell {

    @IBOutlet weak var payment_name: UILabel!
    @IBOutlet weak var radio_img: UIImageView!
    @IBOutlet weak var bg_layout: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
