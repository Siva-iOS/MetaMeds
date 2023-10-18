//
//  RateVC.swift
//  MetaMeds
//
//  Created by Ajeeth Kumar on 13/10/23.
//

import UIKit
import Cosmos

protocol RateDismiss
{
    func DismissResult()
}
class RateVC: UIViewController {

    @IBOutlet weak var background_layout: UIView!
    
    @IBOutlet weak var bg_layout: UIView!
    
    @IBOutlet weak var close_btn: UIButton!
    
    @IBOutlet weak var cosmos: CosmosView!
    
    @IBOutlet weak var exp_txt: UITextView!
    
    var delegate : RateDismiss!
    
    @IBOutlet weak var submit_btn: UIButton!
    
    var reqID = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        background_layout.backgroundColor = UIColor.black.withAlphaComponent(0.6)
//        cosmos.settings.emptyColor = UIColor.gray
//        cosmos.settings.emptyBorderColor = UIColor.init(named: "AppColor")!
//        cosmos.settings.filledColor = UIColor.init(named: "AppColor")!
        cosmos.rating = 0
        self.bg_layout.layer.cornerRadius = 10
        self.close_btn.setImage(UIImage.init(named: "close")?.maskWithColor(color: UIColor.init(named: "AppColor")!), for: .normal)
        exp_txt.layer.cornerRadius = 8
        exp_txt.layer.borderColor = UIColor.init(named: "AppColor")!.cgColor
        exp_txt.delegate = self
        exp_txt.textColor = UIColor.lightGray
        exp_txt.text = "  Describe your Experience..."
        self.submit_btn.layer.cornerRadius = 10
        self.submit_btn.layer.masksToBounds = true
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        let touch = touches.first
        if touch?.view == self.background_layout
        {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    @IBAction func close_onClick(_ sender: Any) 
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func submit_onClick(_ sender: Any) {
        var review = ""
        if exp_txt.text == "  Describe your Experience..."
        {
            review = ""
        }
        else
        {
            review = exp_txt.text
        }
        if validation()
        {
            let upload = UploadRatingObj(user_id: UserObject().RetriveObject().data!.id, id: reqID, rating: cosmos.rating, review: review)
            
            HomeViewModel.RatingService(param: upload, header: UploadHeaderObj(Authorization: UserObject().RetriveObject().data!.auth_token!), Showit: true)
            {
                DispatchQueue.main.async
                {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0)
                    {
                        self.dismiss(animated: true){
                            let tabBar = UIStoryboard(name:"TabBar", bundle: nil).instantiateViewController(withIdentifier:"TabBarVC") as! TabBarVC
                            let vc = UINavigationController.init(rootViewController: tabBar)
                            tabBar.loadViewIfNeeded()
                            tabBar.selectedIndex = 2
                            let appdelegate = UIApplication.shared.delegate as! AppDelegate
                            appdelegate.window?.rootViewController = vc
                        }
                    }
                }
            }
        }
        
    }
    func validation() -> Bool
    {
        self.view.endEditing(true)
        guard cosmos.rating != 0
        else
        {
            Toast(message: "Please select rating", view: self.view)
            return false
        }
        
        guard exp_txt.text != "  Describe your Experience..."
        else
        {
            Toast(message: "Please enter your experience", view: self.view)
            return false
        }
        guard let exp = exp_txt.text, !exp.isEmpty
        else
        {
            Toast(message: "Please enter your experience", view: self.view)
            return false
        }
        return true
    }
    
    
}
extension RateVC: UITextViewDelegate
{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "  Describe your Experience..."
            textView.textColor = UIColor.lightGray
        }
    }
}

