//
//  NotificationCell.swift
//  MetaMeds
//
//  Created by Ajeeth Kumar on 09/10/23.
//

import UIKit

class NotificationCell: UITableViewCell {

    
    @IBOutlet weak var header_lbl: UILabel!
    
    @IBOutlet weak var content_lbl: UILabel!
    
    @IBOutlet weak var time_lbl: UILabel!
    
    @IBOutlet weak var bg_layout: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()

        ApplyShadowView.setCardView(view: bg_layout, cornerRadius: 10, setColor: UIColor.white, shadowRadius: 1.5, Shadowopacity: 1.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
