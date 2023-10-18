//
//  UnderMaintananceVc.swift
//  HurryBunny
//
//  Created by Smarthermacmini on 25/12/20.
//  Copyright © 2020 Smarthermacmini. All rights reserved.
//

import UIKit

class UnderMaintananceVc: UIViewController {

    @IBOutlet weak var emptyLbl: UILabel!
    @IBOutlet weak var empty_img: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        empty_img.sd_setImage(with: URL.init(string: "http://15.185.65.116/adminpanel/public/image/site.gif"))
      
    }

    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = true
    }
    
}
