//
//  RequestPopupVC.swift
//  MetaMeds
//
//  Created by Sivasankar on 13/10/23.
//

import UIKit

class RequestPopupVC: UIViewController {

    @IBOutlet weak var background_layout: UIView!
    @IBOutlet weak var bg_layout: UIView!
    
    @IBOutlet weak var close_btn: UIButton!
    
    @IBOutlet weak var yes_btn: UIButton!
    
    @IBOutlet weak var no_btn: UIButton!
    
    var reqID = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        background_layout.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        self.bg_layout.layer.cornerRadius = 10
        self.close_btn.setImage(UIImage.init(named: "close")?.maskWithColor(color: UIColor.init(named: "AppColor")!), for: .normal)
        self.yes_btn.layer.borderWidth = 1
        self.yes_btn.layer.borderColor = UIColor.black.cgColor
        self.yes_btn.layer.cornerRadius = 10
        self.yes_btn.layer.masksToBounds = true
        self.no_btn.layer.borderWidth = 1
        self.no_btn.layer.borderColor = UIColor.black.cgColor
        self.no_btn.layer.cornerRadius = 10
        self.no_btn.layer.masksToBounds = true
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        let touch = touches.first
        if touch?.view == self.background_layout
        {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func yes_onClick(_ sender: Any)
    {
        dismiss(animated: true){
              print("Dismissed 1")
            let storyboard = UIStoryboard.init(name: "TabBar", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "RateVC") as! RateVC
            vc.reqID = self.reqID
            vc.delegate = self
            vc.modalPresentationStyle = .overCurrentContext
            UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
            }
        
    }
    
    @IBAction func no_onClick(_ sender: Any) 
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func close_onClick(_ sender: Any) 
    {
        self.dismiss(animated: true, completion: nil)
    }
}

extension RequestPopupVC: RateDismiss
{
    func DismissResult() {
        self.dismiss(animated: true, completion: nil)
    }
}
