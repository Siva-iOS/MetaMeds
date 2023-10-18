//
//  SelectScreenVC.swift
//  MetaMeds
//
//  Created by Ajeeth Kumar on 11/10/23.
//

import UIKit

class SelectScreenVC: UIViewController {

    @IBOutlet weak var bg_layout: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        ApplyShadowView.setCardView(view: bg_layout, cornerRadius: 10, setColor: UIColor.white, shadowRadius: 1.5, Shadowopacity: 1.0)
    }
    

    @IBAction func blood_onClick(_ sender: Any)
    {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

}
