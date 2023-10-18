//
//  ProfileCell.swift
//  MetaMeds
//
//  Created by Ajeeth Kumar on 09/10/23.
//

import UIKit

class ProfileCell: UITableViewCell {

    @IBOutlet weak var bg_layout: UIView!
    
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var name_lbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
