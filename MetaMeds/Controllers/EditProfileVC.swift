//
//  EditProfileVC.swift
//  MetaMeds
//
//  Created by Ajeeth Kumar on 09/10/23.
//

import UIKit

class EditProfileVC: UIViewController {

    
    @IBOutlet weak var bg_layout: UIView!
    
    @IBOutlet weak var profile_layout: UIView!
    
    @IBOutlet weak var profile_img: UIImageView!
    @IBOutlet weak var bottom_layout: UIView!
    
    @IBOutlet weak var name_layout: UIView!
    
    @IBOutlet weak var name_txt: UITextField!
    @IBOutlet weak var mobile_layout: UIView!
    
    @IBOutlet weak var mobile_txt: UITextField!
    
    @IBOutlet weak var email_layout: UIView!
    
    @IBOutlet weak var email_txt: UITextField!
    
    @IBOutlet weak var gender_layout: UIView!
    
    @IBOutlet weak var gender_lbl: UILabel!
    
    @IBOutlet weak var dob_layout: UIView!
    
    @IBOutlet weak var dob_txt: UITextField!
    
    
    @IBOutlet weak var bloodgroup_layout: UIView!
    
    @IBOutlet weak var bg_lbl: UILabel!
    
    @IBOutlet weak var pincode_layout: UIView!
    
    @IBOutlet weak var pincode_txt: UITextField!
    
    @IBOutlet weak var update_btn: UIButton!

    
    var gender = 0
    var bloodgroup = 0
    let datePicker = UIDatePicker()
    var startDate = ""
    var imagePicker = UIImagePickerController()
    var imageList = Data()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ApplyShadowView.setCardView(view: profile_layout, cornerRadius: 10, setColor: UIColor.white, shadowRadius: 1.5, Shadowopacity: 1.0)
        ApplyShadowView.setCardView(view: bottom_layout, cornerRadius: 10, setColor: UIColor.white, shadowRadius: 1.5, Shadowopacity: 1.0)
        self.bg_layout.layer.cornerRadius = 20
        self.bg_layout.layer.masksToBounds = true
        self.update_btn.layer.cornerRadius = 10
        self.update_btn.layer.masksToBounds = true
        name_layout.layer.cornerRadius = 6
        name_layout.layer.borderColor = UIColor.systemGray4.cgColor
        name_layout.layer.borderWidth = 1
        mobile_layout.layer.cornerRadius = 6
        mobile_layout.layer.borderColor = UIColor.systemGray4.cgColor
        mobile_layout.layer.borderWidth = 1
        email_layout.layer.cornerRadius = 6
        email_layout.layer.borderColor = UIColor.systemGray4.cgColor
        email_layout.layer.borderWidth = 1
        gender_layout.layer.cornerRadius = 6
        gender_layout.layer.borderColor = UIColor.systemGray4.cgColor
        gender_layout.layer.borderWidth = 1
        dob_layout.layer.cornerRadius = 6
        dob_layout.layer.borderColor = UIColor.systemGray4.cgColor
        dob_layout.layer.borderWidth = 1
        bloodgroup_layout.layer.cornerRadius = 6
        bloodgroup_layout.layer.borderColor = UIColor.systemGray4.cgColor
        bloodgroup_layout.layer.borderWidth = 1
        pincode_layout.layer.cornerRadius = 6
        pincode_layout.layer.borderColor = UIColor.systemGray4.cgColor
        pincode_layout.layer.borderWidth = 1
        profile_img.setRounded()
       
        let imageTap = UITapGestureRecognizer.init(target: self, action: #selector(imageAction))
        profile_img.addGestureRecognizer(imageTap)
        let Gendertap = UITapGestureRecognizer.init(target: self, action: #selector(GenderAction))
        gender_layout.addGestureRecognizer(Gendertap)
        let Bloodgrouptap = UITapGestureRecognizer.init(target: self, action: #selector(BloodgroupAction))
        bloodgroup_layout.addGestureRecognizer(Bloodgrouptap)
        showDatePicker()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if #available(iOS 13.0, *) {
                let window = UIApplication.shared.windows.first
                let topPadding = window?.safeAreaInsets.top
                let statusBar = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: topPadding ?? 0.0))
            statusBar.backgroundColor = UIColor.init(named: "AppColor")
                UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.addSubview(statusBar)
            }
        
        self.name_txt.text = UserObject().RetriveObject().data!.name
        self.mobile_txt.text = UserObject().RetriveObject().data!.mobile
        self.email_txt.text = UserObject().RetriveObject().data!.email
        self.gender_lbl.text = UserObject().RetriveObject().data!.is_gender
        self.gender = UserObject().RetriveObject().data!.gender ?? 0
//        self.dob_txt.text = UserObject().RetriveObject().data!.dob
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd MMM,yyyy"

        if let date = dateFormatterGet.date(from: UserObject().RetriveObject().data!.dob ?? "")
        {
            let year = dateFormatterPrint.string(from: date)
            self.dob_txt.text = "\(year)"
            self.startDate = UserObject().RetriveObject().data!.dob ?? ""
        }
        
        self.bg_lbl.text = UserObject().RetriveObject().data!.is_blood_group
        self.bloodgroup = UserObject().RetriveObject().data!.blood_group ?? 0
        self.pincode_txt.text = UserObject().RetriveObject().data!.pincode_id
        self.profile_img.sd_setImage(with: URL.init(string: UserObject().RetriveObject().data!.is_user_profile_image ?? ""))
    }
    
    
    @IBAction func back_onClick(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        bg_layout.roundCorners(corners: [.topLeft, .topRight], radius: 15)
    }
    
    @IBAction func edit_onClick(_ sender: Any)
    {
        self.showAlertWithThreeButton()
    }
    @objc func imageAction()
    {
        self.showAlertWithThreeButton()
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
    

    @IBAction func update_onClick(_ sender: Any) {
        if validation()
        {
            let upload = UploadUpdateProfileObj(user_id: UserObject().RetriveObject().data!.id, name: self.name_txt.text, email: self.email_txt.text, pincode_id : pincode_txt.text, gender: gender, dob: self.startDate, blood_group: bloodgroup, mobile: mobile_txt.text)
            
            LoginViewModel.EditProfileService(param: upload, header: UploadHeaderObj(Authorization: UserObject().RetriveObject().data!.auth_token!), Showit: true)
            {
                DispatchQueue.main.async
                {
                    if self.mobile_txt.text != UserObject().RetriveObject().data!.mobile!
                    {
                        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: "OTPVC") as! OTPVC
                        vc.emailcheck = 1
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                    else
                    {
                        
                    }
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
        
        guard let mobile = mobile_txt.text, !mobile.isEmpty
        else
        {
            Toast(message: "Please enter your mobile number", view: self.view)
            return false
        }
        guard let mobile1 = mobile_txt.text, mobile1.count == 10
        else
        {
            Toast(message: "Please enter valid mobile number", view: self.view)
            return false
        }
        
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
        
        guard let dob = dob_txt.text, !dob.isEmpty
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
        
        return true
    }
    
}

extension EditProfileVC : GenderProto
{
    func GenderResult(Name: String, id: Int)
    {
        self.gender_lbl.text = Name
        self.gender = id
    }
}

extension EditProfileVC : BloodGroupProto
{
    func BloodGroupResult(Name: String, id: Int)
    {
        self.bg_lbl.text = Name
        self.bloodgroup = id
    }
}
extension EditProfileVC:  UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    @objc func showAlertWithThreeButton()
    {
            let alert = UIAlertController(title: "Add photo", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Take photo", style: .default, handler: { (_) in
                self.openCamera()
            }))
            
            alert.addAction(UIAlertAction(title: "Choose from gallery", style: .default, handler: { (_) in
                self.openGallery()
            }))
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
                print("You've pressed the destructive")
            }))
            self.present(alert, animated: true, completion: nil)
    }
    
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
        {
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openGallery()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary))
        {
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have gallery", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        if let editedImage = info[.originalImage] as? UIImage
        {
            picker.dismiss(animated: true, completion: nil)
            //self.profile_img.image = editedImage
            
            var param : [String:AnyObject] = [:]

            param["user_id"] = UserObject().RetriveObject().data?.id as AnyObject
            

            var mediaparam : [String:Data] = [:]
            mediaparam["profile_image"] = editedImage.jpegData(compressionQuality: 0.2)

            HomeViewModel.ProfilePicService(param: param, upload: mediaparam, header: UploadHeaderObj(Authorization: UserObject().RetriveObject().data?.auth_token!), Showit: true)
            {
                DispatchQueue.main.async
                {
                    Toast(message: "Profile picture updated", view: self.view)
                    self.profile_img.image = editedImage
                }
            }
        }
    }
    
    //Cancel Delegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.isNavigationBarHidden = false
        self.dismiss(animated: true, completion: nil)
    }
}
