//
//  OTPVC.swift
//  MetaMeds
//
//  Created by Ajeeth Kumar on 05/10/23.
//

import UIKit

class OTPVC: UIViewController,UITextFieldDelegate {

    var ForgotPassword = 0
    
    @IBOutlet weak var bg_layout: UIView!
    
    @IBOutlet weak var back_btn: UIButton!
    @IBOutlet weak var BACK_BTN: UIButton!
    @IBOutlet weak var otp_layout: UIStackView!
 
    @IBOutlet weak var resendBtn: UIButton!
    @IBOutlet weak var counterLbl: UILabel!
    @IBOutlet weak var otp4: UITextField!
    @IBOutlet weak var otp3: UITextField!
    @IBOutlet weak var otp2: UITextField!
    @IBOutlet weak var otp1: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    var checkboxcheck = false
    var countTimer: Timer!
    var counter = 60
    var emailcheck = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ApplyShadowView.setCardView(view: bg_layout, cornerRadius: 20, setColor: UIColor.white, shadowRadius: 2.5, Shadowopacity: 2.0)
        self.loginBtn.layer.cornerRadius = 10
        self.loginBtn.layer.masksToBounds = true
        
        if emailcheck == 0
        {
            self.back_btn.isHidden = true
            self.BACK_BTN.isHidden = true
        }
        else
        {
            self.back_btn.isHidden = false
            self.BACK_BTN.isHidden = false
        }
        
        otp1.layer.cornerRadius = 6
        otp2.layer.cornerRadius = 6
        otp3.layer.cornerRadius = 6
        otp4.layer.cornerRadius = 6
        otp1.layer.borderColor = UIColor.lightGray.cgColor
        otp1.layer.borderWidth = 1
        otp2.layer.borderColor = UIColor.lightGray.cgColor
        otp2.layer.borderWidth = 1
        otp3.layer.borderColor = UIColor.lightGray.cgColor
        otp3.layer.borderWidth = 1
        otp4.layer.borderColor = UIColor.lightGray.cgColor
        otp4.layer.borderWidth = 1
        
        otp1.delegate = self
        otp2.delegate = self
        otp3.delegate = self
        otp4.delegate = self
        
        otp1.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        otp2.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        otp3.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        otp4.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        
        otp1.becomeFirstResponder()
        
        self.counterLbl.isHidden = false
        resendBtn.isHidden = true
        self.countTimer = Timer.scheduledTimer(timeInterval: 1 ,target: self,selector: #selector(self.changeTitle),userInfo: nil,repeats: true)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = true
    }
   
    @IBAction func back_onClick(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func resend_Onclick(_ sender: Any)
    {
        let upload = UploadOTPObj(user_id: UserObject().RetriveObject().data!.id, mobile_number: UserObject().RetriveObject().data!.mobile)
        LoginViewModel.ResendOTPService(param: upload, Showit: true)
        {
            DispatchQueue.main.async
                {
                    self.counter = 60
                    self.counterLbl.isHidden = false
                    self.resendBtn.isHidden = true
                    self.countTimer = Timer.scheduledTimer(timeInterval: 1 ,target: self,selector: #selector(self.changeTitle),userInfo: nil,repeats: true)
                }
        }
    }

    @objc func changeTitle()
    {
        self.counter -= 1
        if self.counter >= 60
        {
          self.counterLbl.text = "Resend code in \((self.counter % 3600) / 60):\((self.counter % 3600) % 60) sec"
            counterLbl.changeTextColor(ofText: "\((self.counter % 3600) / 60):\((self.counter % 3600) % 60) sec", with: UIColor.init(named: "AppColor")!)
        }
        if self.counter == 0
        {
          self.countTimer?.invalidate()
          self.counterLbl.isHidden = true
          self.resendBtn.isHidden = false
        }
        else
        {
            self.counterLbl.text = "Resend code in \((self.counter % 3600) % 60) sec"
            counterLbl.changeTextColor(ofText: "\((self.counter % 3600) % 60) sec", with: UIColor.init(named: "AppColor")!)
        }
    }
    
    @IBAction func login_onClick(_ sender: Any)
    {
        if self.otp1.text!.isEmpty || self.otp2.text!.isEmpty || self.otp3.text!.isEmpty || self.otp4.text!.isEmpty
        {
            Toast(message: "Please enter valid OTP", view: self.view)
        }
        
        else
        {
            let otp = self.otp1.text! +  self.otp2.text! +  self.otp3.text! +  self.otp4.text!

            let upload = UploadOTPObj(user_id: UserObject().RetriveObject().data!.id, mobile_number: UserObject().RetriveObject().data!.mobile, otp: otp)
            LoginViewModel.OTPService(param: upload, Showit: true)
            {
                DispatchQueue.main.async
                    {
                        print(UserObject().RetriveObject().data!.step)
                        if UserObject().RetriveObject().data!.step == 2
                        {
                            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                            let vc = storyboard.instantiateViewController(withIdentifier: "UpdateProfileVC") as! UpdateProfileVC
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                        else
                        {
                            let appdelegate = UIApplication.shared.delegate as! AppDelegate
                            appdelegate.SetRootController(StoryboardName: "TabBar", Identifier: "TabBarVC")
                        }
                        
                }
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        let maxLength = 1
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    
    @objc func textFieldDidChange(textField: UITextField)
    {
        let text = textField.text
        if  text?.count == 1
        {
            switch textField
            {
            case otp1:
                otp1.layer.borderColor = UIColor.init(named: "AppColor")!.cgColor
                otp1.layer.borderWidth = 1
                otp2.becomeFirstResponder()
            case otp2:
                otp2.layer.borderColor = UIColor.init(named: "AppColor")!.cgColor
                otp2.layer.borderWidth = 1
                otp3.becomeFirstResponder()
            case otp3:
                otp3.layer.borderColor = UIColor.init(named: "AppColor")!.cgColor
                otp3.layer.borderWidth = 1
                otp4.becomeFirstResponder()
            case otp4:
                otp4.layer.borderColor = UIColor.init(named: "AppColor")!.cgColor
                otp4.layer.borderWidth = 1
                otp4.resignFirstResponder()
            default:
                break
            }
        }
        
        if  text?.count == 0
        {
            switch textField
            {
            case otp1:
                otp1.layer.borderColor = UIColor.lightGray.cgColor
                otp1.layer.borderWidth = 1
                otp1.becomeFirstResponder()
            case otp2:
                otp2.layer.borderColor = UIColor.lightGray.cgColor
                otp2.layer.borderWidth = 1
                otp1.becomeFirstResponder()
            case otp3:
                otp3.layer.borderColor = UIColor.lightGray.cgColor
                otp3.layer.borderWidth = 1
                otp2.becomeFirstResponder()
            case otp4:
                otp4.layer.borderColor = UIColor.lightGray.cgColor
                otp4.layer.borderWidth = 1
                otp3.becomeFirstResponder()
            default:
                break
            }
        }
    }
}
