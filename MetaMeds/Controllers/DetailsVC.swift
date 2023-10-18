//
//  DetailsVC.swift
//  MetaMeds
//
//  Created by Ajeeth Kumar on 09/10/23.
//

import UIKit

class DetailsVC: UIViewController {

    @IBOutlet weak var bg_layout: UIView!
    @IBOutlet weak var details_layout: UIView!
    
    @IBOutlet weak var name_lbl: UILabel!
    
    @IBOutlet weak var age_lbl: UILabel!
    
    @IBOutlet weak var bg_lbl: UILabel!
    
    @IBOutlet weak var date_lbl: UILabel!
    
    
    @IBOutlet weak var call_btn: UIButton!
    
    
    @IBOutlet weak var address_lbl: UILabel!
    
    var details : PostDataObj?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        ApplyShadowView.setCardView(view: details_layout, cornerRadius: 20, setColor: UIColor.white, shadowRadius: 2.5, Shadowopacity: 2.0)
        self.name_lbl.text = details?.patient_name
        self.age_lbl.text = "\(details?.age ?? "")"
        self.bg_lbl.text = details?.is_blood_group
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd MMM,yyyy"
        
        if let date = dateFormatterGet.date(from: details?.dob ?? "")
        {
            self.date_lbl.text = dateFormatterPrint.string(from: date)
        }
        self.address_lbl.text = details?.address
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if #available(iOS 13.0, *) {
                let window = UIApplication.shared.windows.first
                let topPadding = window?.safeAreaInsets.top
                let statusBar = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: topPadding ?? 0.0))
            statusBar.backgroundColor = UIColor.init(named: "AppColor")
                UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.addSubview(statusBar)
            }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        bg_layout.roundCorners(corners: [.topLeft, .topRight], radius: 15)
    }
    
    
    @IBAction func back_onClick(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func callbtn_onClick(_ sender: Any)
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
            callNumber(Number: details?.mobile ?? "")
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
