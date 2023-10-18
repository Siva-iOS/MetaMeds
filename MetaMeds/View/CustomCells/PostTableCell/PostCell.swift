//
//  PostCell.swift
//  MetaMeds
//
//  Created by Ajeeth Kumar on 06/10/23.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet weak var bg_layout: UIView!
    @IBOutlet weak var name_lbl: UILabel!
    
    @IBOutlet weak var age_lbl: UILabel!
    
    @IBOutlet weak var bg_lbl: UILabel!
    
    @IBOutlet weak var date_lbl: UILabel!
    
    @IBOutlet weak var call_btn: UIButton!
    
    @IBOutlet weak var address_lbl: UILabel!
    
    @IBOutlet weak var received_btn: UIButton!
    
    
    @IBOutlet weak var emergeny_layout: UIView!
    
    @IBOutlet weak var round_view: UIView!
    
    var postList : PostDataObj?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ApplyShadowView.setCardView(view: bg_layout, cornerRadius: 10, setColor: UIColor.white, shadowRadius: 1.5, Shadowopacity: 1.0)
//        let radius = CGRectGetWidth(self.frame) / 2
        self.round_view.layer.cornerRadius = 2.5
        self.round_view.layer.masksToBounds = true
        self.received_btn.layer.borderWidth = 1
        self.received_btn.layer.borderColor = UIColor.init(named: "AppColor")?.cgColor
        self.received_btn.layer.cornerRadius = 10
        self.received_btn.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func PostCellValues(postList:PostDataObj, showBtn: Bool)
    {
        self.postList = postList
        self.name_lbl.text = postList.patient_name
        self.age_lbl.text = "\(postList.age ?? "")"
        self.bg_lbl.text = postList.is_blood_group
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd MMM,yyyy"
        
        if let date = dateFormatterGet.date(from: postList.request_date ?? "")
        {
            self.date_lbl.text = dateFormatterPrint.string(from: date)
        }
        self.address_lbl.text = postList.address
        self.call_btn.addTarget(self, action: #selector(handleTap1), for: .touchUpInside)
        
        if postList.is_critical == 1
        {
            self.emergeny_layout.isHidden = false
        }
        else
        {
            self.emergeny_layout.isHidden = true
        }
        if showBtn == true
        {
            self.received_btn.isHidden = false
        }
        else
        {
            self.received_btn.isHidden = true
        }
    }
    @objc func handleTap1(_ sender: UIButton)
    {
        if UserObject().RetriveObject().data!.step == 1
        {
            let navigate = UIStoryboard.init(name: "Main", bundle: nil)
            let product = navigate.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            product.check = 1
            UIApplication.topViewController()?.navigationController?.pushViewController(product, animated: true)
        }
        else
        {
            callNumber(Number: postList?.mobile ?? "")
        }
    }
    
    private func callNumber(Number:String)
    {
        DispatchQueue.main.async
            {
                if let phoneCallURL = URL(string:"telprompt://\(Number)")
                {
                    let application:UIApplication = UIApplication.shared
                    if (application.canOpenURL(phoneCallURL)) {
                        if #available(iOS 10.0, *) {
                            application.open(phoneCallURL, options: [:], completionHandler: nil)
                        } else {
                            // Fallback on earlier versions
                            application.openURL(phoneCallURL as URL)
                        }
                    }
                }
        }
    }
    
}
