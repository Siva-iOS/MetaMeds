//
//  UpdateProfileVC.swift
//  MetaMeds
//
//  Created by Ajeeth Kumar on 05/10/23.
//

import UIKit

class UpdateProfileVC: UIViewController {
    
    @IBOutlet weak var bg_layout: UIView!
    
    @IBOutlet weak var inner_layout: UIView!
    
    @IBOutlet weak var name_layout: UIView!
    
    @IBOutlet weak var name_txt: UITextField!
    
    @IBOutlet weak var email_layout: UIView!
    
    @IBOutlet weak var email_txt: UITextField!
    
    @IBOutlet weak var gender_layout: UIView!
    
    @IBOutlet weak var gender_lbl: UILabel!
    
    @IBOutlet weak var dob_layout: UIView!
    
    @IBOutlet weak var dob_txt: UITextField!
    
    @IBOutlet weak var blood_layout: UIView!
    
    @IBOutlet weak var blood_lbl: UILabel!
    
    @IBOutlet weak var pincode_layout: UIView!
    
    @IBOutlet weak var pincode_txt: UITextField!
    
    @IBOutlet weak var submit_btn: UIButton!
    
    var gender = 0
    var bloodgroup = 0
    let datePicker = UIDatePicker()
    var startDate = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ApplyShadowView.setCardView(view: bg_layout, cornerRadius: 20, setColor: UIColor.white, shadowRadius: 2.5, Shadowopacity: 2.0)
        self.inner_layout.layer.cornerRadius = 20
        self.inner_layout.layer.masksToBounds = true
        self.submit_btn.layer.cornerRadius = 10
        self.submit_btn.layer.masksToBounds = true
        name_layout.layer.cornerRadius = 6
        name_layout.layer.borderColor = UIColor.systemGray4.cgColor
        name_layout.layer.borderWidth = 1
        email_layout.layer.cornerRadius = 6
        email_layout.layer.borderColor = UIColor.systemGray4.cgColor
        email_layout.layer.borderWidth = 1
        gender_layout.layer.cornerRadius = 6
        gender_layout.layer.borderColor = UIColor.systemGray4.cgColor
        gender_layout.layer.borderWidth = 1
        dob_layout.layer.cornerRadius = 6
        dob_layout.layer.borderColor = UIColor.systemGray4.cgColor
        dob_layout.layer.borderWidth = 1
        blood_layout.layer.cornerRadius = 6
        blood_layout.layer.borderColor = UIColor.systemGray4.cgColor
        blood_layout.layer.borderWidth = 1
        pincode_layout.layer.cornerRadius = 6
        pincode_layout.layer.borderColor = UIColor.systemGray4.cgColor
        pincode_layout.layer.borderWidth = 1
       
        let Gendertap = UITapGestureRecognizer.init(target: self, action: #selector(GenderAction))
        gender_layout.addGestureRecognizer(Gendertap)
        let Bloodgrouptap = UITapGestureRecognizer.init(target: self, action: #selector(BloodgroupAction))
        blood_layout.addGestureRecognizer(Bloodgrouptap)
        showDatePicker()
        BloodGroupData()
    }
    
    func BloodGroupData()
    {
        LoginViewModel.BloodGroupService(param: UploadLoginObj(), Showit: true)
        {
            DispatchQueue.main.async
            {
            }
        }
    }
    
    @objc func GenderAction()
    {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PopupVC") as! PopupVC
        vc.modalPresentationStyle = .overCurrentContext
        vc.type = "Gender"
        vc.Genderdelegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func BloodgroupAction()
    {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PopupVC") as! PopupVC
        vc.modalPresentationStyle = .overCurrentContext
        vc.type = "BG"
        vc.BloodGroupdelegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        let calendar = Calendar(identifier: .gregorian)
        
        let currentDate = Date()
        var components = DateComponents()
        components.calendar = calendar
        
        components.year = 0
        components.month = 0
        let maxDate = calendar.date(byAdding: components, to: currentDate)!
        
        components.year = -150
        let minDate = calendar.date(byAdding: components, to: currentDate)!
        
        datePicker.minimumDate = minDate
        
        datePicker.maximumDate = maxDate
        datePicker.locale = .current
        
        if #available(iOS 14.0, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        
        dob_txt.tintColor = UIColor.clear
        dob_txt.inputAccessoryView = toolbar
        dob_txt.inputView = datePicker
        dob_txt.resignFirstResponder()
    }
    
    @objc func donedatePicker(){
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd MMM,yyyy"

        startDate = dateFormatterGet.string(from: datePicker.date)
        
        if let date = dateFormatterGet.date(from: startDate)
        {
            dob_txt.text = dateFormatterPrint.string(from: date)
        }
        
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    @IBAction func submit_onClick(_ sender: Any)
    {
        if validation()
        {
            let upload = UploadUpdateProfileObj(user_id: UserObject().RetriveObject().data!.id, name: self.name_txt.text, email: self.email_txt.text, pincode_id : pincode_txt.text, gender: gender, dob: self.startDate, blood_group: bloodgroup)
            
            LoginViewModel.UpdateProfileService(param: upload, header: UploadHeaderObj(Authorization: UserObject().RetriveObject().data!.auth_token!), Showit: true)
            {
                DispatchQueue.main.async
                {
                    let appdelegate = UIApplication.shared.delegate as! AppDelegate
                    appdelegate.SetRootController(StoryboardName: "TabBar", Identifier: "TabBarVC")
                }
            }
        }
        
    }
    
    func isValidEmail(_ email: String) -> Bool
    {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func validation() -> Bool
    {
        self.view.endEditing(true)
        guard let name = name_txt.text?.trimString(), !name.isEmpty
        else
        {
            Toast(message: "Please enter user name", view: self.view)
            name_txt.becomeFirstResponder()
            return false
        }
        
//        guard let name1 = name_txt.text?.trimString(),  name1.count > 2
//        else
//        {
//            Toast(message: "Name should contains atleast 3 digits", view: self.view)
//            name_txt.becomeFirstResponder()
//            return false
//        }
        
        guard self.isValidEmail(self.email_txt.text!)
        else
        {
            Toast(message: "Please enter valid email address", view: self.view)
            email_txt.becomeFirstResponder()
            return false
        }
        
        guard gender != 0
        else
        {
            Toast(message: "Please enter gender", view: self.view)
            return false
        }
        
        guard dob_txt.text != "D.O.B"
        else
        {
            Toast(message: "Please enter dob", view: self.view)
            return false
        }
        
        guard bloodgroup != 0
        else
        {
            Toast(message: "Please enter blood group", view: self.view)
            return false
        }
        
        guard let pincode = pincode_txt.text, !pincode.isEmpty
        else
        {
            Toast(message: "Please enter pincode", view: self.view)
            pincode_txt.becomeFirstResponder()
            return false
        }
        guard let pincode1 = pincode_txt.text, pincode1.count == 6
        else
        {
            Toast(message: "Please enter valid pincode", view: self.view)
            pincode_txt.becomeFirstResponder()
            return false
        }
        
        return true
    }
    
}

extension UpdateProfileVC : GenderProto
{
    func GenderResult(Name: String, id: Int)
    {
        self.gender_lbl.text = Name
        self.gender = id
    }
}

extension UpdateProfileVC : BloodGroupProto
{
    func BloodGroupResult(Name: String, id: Int)
    {
        self.blood_lbl.text = Name
        self.bloodgroup = id
    }
}
