//
//  PostVC.swift
//  MetaMeds
//
//  Created by Ajeeth Kumar on 06/10/23.
//

import UIKit
import Photos
import BSImagePicker
import GooglePlaces

var FileName : [String] = []

class PostVC: UIViewController {

    @IBOutlet weak var bg_layout: UIView!
    @IBOutlet weak var patientname_txt: UITextField!
    
    @IBOutlet weak var attendeename_txt: UITextField!
    
    @IBOutlet weak var mobile_txt: UITextField!
    
    @IBOutlet weak var dob_txt: UITextField!
    
    @IBOutlet weak var bg_txt: UITextField!
    
    
    @IBOutlet weak var requestType_txt: UITextField!
    
    
    @IBOutlet weak var quantity_txt: UITextField!
 
    @IBOutlet weak var location_txt: UITextField!
    
    @IBOutlet weak var date_txt: UITextField!
    
    @IBOutlet weak var address_txt: UITextField!
    
    @IBOutlet weak var upload_btn: UIButton!
    
    @IBOutlet weak var galleryCV: UICollectionView!
    @IBOutlet weak var galleryflow: UICollectionViewFlowLayout!
    @IBOutlet weak var galleryCV_Height: NSLayoutConstraint!
    
    @IBOutlet weak var critical_checkbox: UIButton!
    
    @IBOutlet weak var terms_checkbox: UIButton!
    
    
    @IBOutlet weak var submit_btn: UIButton!
    var imageList : [Data] = []
    var pdf_data : Data!
    
    let datePicker = UIDatePicker()
    let datePicker1 = UIDatePicker()
    var dobDate = ""
    var reqDate = ""
    var lan1:Double?
    var lon1:Double?
    var mediaparam : [String:Data] = [:]
    var Attachment = 0
    var arrayOfImages = [UIImage]()
    var imagePicker = UIImagePickerController()
    var bloodgroup = 0
    var location = 0
    var quantity = 0
    var reqtype = 0
    var critical = 0
    var iconClick = true
    var criticalcheck = false
    var termscheck = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.submit_btn.layer.cornerRadius = 10
        self.submit_btn.layer.masksToBounds = true
        mobile_txt.maxLength = 10
        let Bloodgrouptap = UITapGestureRecognizer.init(target: self, action: #selector(BloodgroupAction))
        bg_txt.addGestureRecognizer(Bloodgrouptap)
        let locationtap = UITapGestureRecognizer.init(target: self, action: #selector(LocationAction))
        location_txt.addGestureRecognizer(locationtap)
        let reqTap = UITapGestureRecognizer.init(target: self, action: #selector(ReqAction))
        requestType_txt.addGestureRecognizer(reqTap)
        let quantityTap = UITapGestureRecognizer.init(target: self, action: #selector(quantityAction))
        quantity_txt.addGestureRecognizer(quantityTap)
        
        showDatePicker()
        showDatePicker1()
        self.address_txt.delegate = self
        galleryCV_Height.constant = 0
        
        let flow = CollectionViewLayout()
        galleryCV.collectionViewLayout = flow
        
        galleryCV_Height.constant = 0
        self.galleryCV.dataSource = self
        self.galleryCV.delegate = self
        self.galleryCV.reloadData()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        bg_layout.roundCorners(corners: [.topLeft, .topRight], radius: 15)
    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = true
        if #available(iOS 13.0, *) {
                let window = UIApplication.shared.windows.first
                let topPadding = window?.safeAreaInsets.top
                let statusBar = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: topPadding ?? 0.0))
            statusBar.backgroundColor = UIColor.init(named: "AppColor")
                UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.addSubview(statusBar)
            }
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
    
    @objc func LocationAction()
    {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PopupVC") as! PopupVC
        vc.modalPresentationStyle = .overCurrentContext
        vc.type = "Location"
        vc.Locationdelegate = self
        self.present(vc, animated: true, completion: nil)
    }
    @objc func ReqAction()
    {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PopupVC") as! PopupVC
        vc.modalPresentationStyle = .overCurrentContext
        vc.type = "Req"
        vc.Reqdelegate = self
        self.present(vc, animated: true, completion: nil)
    }
    @objc func quantityAction()
    {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PopupVC") as! PopupVC
        vc.modalPresentationStyle = .overCurrentContext
        vc.type = "Quantity"
        vc.Quantitydelegate = self
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

        dobDate = dateFormatterGet.string(from: datePicker.date)
        
        if let date = dateFormatterGet.date(from: dobDate)
        {
            dob_txt.text = dateFormatterPrint.string(from: date)
        }
        
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    func showDatePicker1(){
        //Formate Date
        datePicker1.datePickerMode = .date
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker1));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker1));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        let calendar = Calendar(identifier: .gregorian)
        
        let currentDate = Date()
        var components = DateComponents()
        components.calendar = calendar
        
        components.year = 0
        components.month = 12
        let maxDate = calendar.date(byAdding: components, to: currentDate)!
        
        components.year = 10
        let minDate = calendar.date(byAdding: components, to: currentDate)!
        
        datePicker1.minimumDate = currentDate
        
        datePicker1.maximumDate = maxDate
        datePicker1.locale = .current
        
        if #available(iOS 14.0, *) {
            datePicker1.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earliennr versions
        }
        
        date_txt.tintColor = UIColor.clear
        date_txt.inputAccessoryView = toolbar
        date_txt.inputView = datePicker1
        date_txt.resignFirstResponder()
    }
    
    @objc func donedatePicker1(){
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd MMM,yyyy"

        reqDate = dateFormatterGet.string(from: datePicker1.date)
        
        if let date = dateFormatterGet.date(from: reqDate)
        {
            date_txt.text = dateFormatterPrint.string(from: date)
        }
        
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker1(){
        self.view.endEditing(true)
    }

    @IBAction func upload_onClick(_ sender: Any) {
        
//        openDocumentPicker()
        showAlertWithThreeButton()
//        openGallery()
    }
    
    @IBAction func critical_checkboxOnClick(_ sender: Any)
    {
        if criticalcheck == false
        {
            critical_checkbox.setImage(UIImage.init(named: "checkbox_select"), for: .normal)
            criticalcheck = true
            critical = 1
        }
        else
        {
            critical_checkbox.setImage(UIImage.init(named: "checkbox_empty"), for: .normal)
            criticalcheck = false
            critical = 0
        }
    }
    @IBAction func terms_checkboxOnClick(_ sender: Any)
    {
        if termscheck == false
        {
            terms_checkbox.setImage(UIImage.init(named: "checkbox_select"), for: .normal)
            termscheck = true
        }
        else
        {
            terms_checkbox.setImage(UIImage.init(named: "checkbox_empty"), for: .normal)
            termscheck = false
        }
    }
    @IBAction func terms_onClick(_ sender: Any) {
    }
    @IBAction func privacy_onClick(_ sender: Any) {
    }
    
    @IBAction func submit_onClick(_ sender: Any)
    {
        if validation()
        {
            var param : [String:AnyObject] = [:]

            param["user_id"] = UserObject().RetriveObject().data?.id as AnyObject
            param["patient_name"] = patientname_txt.text as AnyObject
            param["attendee_name"] = attendeename_txt.text as AnyObject
            param["mobile"] = mobile_txt.text as AnyObject
            param["dob"] = dobDate as AnyObject
            param["blood_group"] = self.bloodgroup as AnyObject
            param["request_id"] = self.reqtype as AnyObject
            param["quantity"] = self.quantity as AnyObject
            param["location_id"] = location as AnyObject
            param["latitude"] = lan1 as AnyObject
            param["longitude"] = lon1 as AnyObject
            param["address"] = address_txt.text as AnyObject
            param["request_date"] = reqDate as AnyObject
            param["is_critical"] = critical as AnyObject
        
            HomeViewModel.CreatePostService(param: param, mediaparam: "image", mediaData: self.imageList, header: UploadHeaderObj.init(Authorization: UserObject().RetriveObject().data?.auth_token!), Showit: true)
            {
                DispatchQueue.main.async
                {
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
    
    func isValidEmail(_ email: String) -> Bool
    {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func validation() -> Bool
    {
        self.view.endEditing(true)
        guard let name = patientname_txt.text?.trimString(), !name.isEmpty
        else
        {
            Toast(message: "Please enter patient name", view: self.view)
            patientname_txt.becomeFirstResponder()
            return false
        }
        
        guard let name1 = attendeename_txt.text?.trimString(), !name1.isEmpty
        else
        {
            Toast(message: "Please enter attendee name", view: self.view)
            attendeename_txt.becomeFirstResponder()
            return false
        }
        guard let mobile = mobile_txt.text, !mobile.isEmpty
        else
        {
            Toast(message: "Please enter your mobile number", view: self.view)
            mobile_txt.becomeFirstResponder()
            return false
        }
        guard let mobile1 = mobile_txt.text, mobile1.count == 10
        else
        {
            Toast(message: "Please enter valid mobile number", view: self.view)
            mobile_txt.becomeFirstResponder()
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
        
        guard reqtype != 0
        else
        {
            Toast(message: "Please enter request type", view: self.view)
            return false
        }
        guard quantity != 0
        else
        {
            Toast(message: "Please enter quantity", view: self.view)
            return false
        }
        
        guard location != 0
        else
        {
            Toast(message: "Please enter location", view: self.view)
            return false
        }
        guard let requiredDate = date_txt.text, !requiredDate.isEmpty
        else
        {
            Toast(message: "Please enter required date", view: self.view)
            return false
        }
        
        guard let address = address_txt.text, !address.isEmpty
        else
        {
            Toast(message: "Please enter address", view: self.view)
            address_txt.becomeFirstResponder()
            return false
        }
        guard imageList.count != 0
        else
        {
            Toast(message: "Please add requisition form", view: self.view)
            return false
        }
        
        guard termscheck != false
        else
        {
            Toast(message: "Please agree the terms and conditions", view: self.view)
            return false
        }
        
        return true
    }
}
//MARK:- UIcollectionView DataSource & Delegate
extension PostVC : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CreateGalleryCell", for: indexPath) as! CreateGalleryCell
        
        cell.selected_img.image = UIImage.init(data: self.imageList[indexPath.item])
        cell.cancelBtn.addTarget(self, action: #selector(DeleteAction), for: .touchUpInside)
        cell.cancelBtn.tag = indexPath.row
        cell.cancelBtn.isUserInteractionEnabled = true
        if self.imageList.count == 0
        {
            self.galleryCV_Height.constant = 0
        }
        else if self.imageList.count == 1 || self.imageList.count == 2
        {
            self.galleryCV_Height.constant = (self.galleryCV.bounds.width-10)/2
        }
        else if self.imageList.count == 3
        {
            self.galleryCV_Height.constant = ((self.galleryCV.bounds.width-10)/2) * 2
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let width = (collectionView.bounds.width-10)/2
        return CGSize(width: width, height: width)
    }
    
    @objc func DeleteAction(_ sender: UIButton)
    {
        self.imageList.remove(at: sender.tag)
//        FileName.remove(at: sender.tag)
        if self.imageList.count == 0
        {
            self.galleryCV_Height.constant = 0
        }
        else if self.imageList.count == 1 || self.imageList.count == 2
        {
            self.galleryCV_Height.constant = (self.galleryCV.bounds.width-10)/2
        }
        else if self.imageList.count == 3
        {
            self.galleryCV_Height.constant = ((self.galleryCV.bounds.width-10)/2) * 2
        }
        self.galleryCV.reloadData()
    }
    
    func getAssetThumbnail(asset: PHAsset) -> UIImage
    {
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        var thumbnail = UIImage()
        option.isSynchronous = true
        manager.requestImage(for: asset, targetSize: CGSize(width: asset.pixelWidth, height: asset.pixelHeight), contentMode: .aspectFill, options: option, resultHandler: {(result, info)->Void in
            thumbnail = result!
        })
        return thumbnail
    }
}
extension String {
    func toImage() -> UIImage? {
        if let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters){
            return UIImage(data: data)
        }
        return nil
    }
}

extension PostVC: GMSAutocompleteViewControllerDelegate, UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.address_txt {
            let autocompleteController = GMSAutocompleteViewController()
//            let filter = GMSAutocompleteFilter()
//            filter.type = .establishment // there are more types if you also need that
//            filter.country = "CA" // this is a standard ISO 3166 country code
//            autocompleteController.autocompleteFilter = filter
            autocompleteController.delegate = self
            autocompleteController.primaryTextColor = UIColor.black
            autocompleteController.secondaryTextColor = UIColor.black
            autocompleteController.primaryTextHighlightColor = UIColor.black
            autocompleteController.modalPresentationStyle = .overCurrentContext
            autocompleteController.modalTransitionStyle = .crossDissolve
            present(autocompleteController, animated: true, completion: nil)
            
            let searchBarTextAttributes: [NSAttributedString.Key : AnyObject] = [NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): UIColor.black, NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue): UIFont.systemFont(ofSize: UIFont.systemFontSize)]
            UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = searchBarTextAttributes
            
//            autocompleteController.primaryTextColor = UIColor.lightGray
//            autocompleteController.secondaryTextColor = UIColor.lightGray
//            autocompleteController.primaryTextHighlightColor = UIColor.white
//            autocompleteController.tableCellSeparatorColor = UIColor.lightGray
//            autocompleteController.tableCellBackgroundColor = UIColor.darkGray
//            autocompleteController.modalPresentationStyle = .overCurrentContext
//            autocompleteController.modalTransitionStyle = .crossDissolve
//            present(autocompleteController, animated: true, completion: nil)
        }
    }
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace){
        self.dismiss(animated: true, completion: nil)
        lan1 = place.coordinate.latitude
         lon1 = place.coordinate.longitude
        let Place: CLLocation =  CLLocation(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation((Place), completionHandler: { (placemarker, error) in
            let address = "\(placemarker?.last?.name ?? "")\(", ")"
            let area = "\(placemarker?.last?.subLocality ?? "")\(", ")"
            let city = "\(placemarker?.last?.locality ?? "")"
            let state = "\(placemarker?.last?.administrativeArea ?? "")\(", ")"
            let postalCode = placemarker?.last?.postalCode ?? ""
            print(address,area,city,state,postalCode)
//            self.address_nameTxt.text = place.name
            self.address_txt.text = place.name
//            self.city_txt.text = city
//            self.pincode_txt.text = postalCode
        })
    }
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}
extension PostVC : BloodGroupProto
{
    func BloodGroupResult(Name: String, id: Int)
    {
        self.bg_txt.text = Name
        self.bloodgroup = id
    }
}
extension PostVC : LocationProto
{
    func LocationResult(Name: String, id: Int)
    {
        self.location_txt.text = Name
        self.location = id
    }
}
extension PostVC : ReqProto
{
    func ReqResult(Name: String, id: Int)
    {
        self.requestType_txt.text = Name
        self.reqtype = id
    }
}
extension PostVC : QuantityProto
{
    func QuantityResult(Name: String, id: Int)
    {
        self.quantity_txt.text = Name
        self.quantity = id
    }
}
extension PostVC:  UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    @objc func showAlertWithThreeButton()
    {
            let alert = UIAlertController(title: "Add photo", message: "", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "Take photo", style: .default, handler: { (_) in
//                self.openCamera()
//            }))
            
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
            
            self.imageList.append(editedImage.jpegData(compressionQuality: 0.2)!)
            
            if self.imageList.count == 0
            {
                self.galleryCV_Height.constant = 0
            }
            else if self.imageList.count == 1 || self.imageList.count == 2
            {
                self.galleryCV_Height.constant = (self.galleryCV.bounds.width-10)/2
            }
            else if self.imageList.count == 3
            {
                self.galleryCV_Height.constant = ((self.galleryCV.bounds.width-10)/2) * 2
            }

            self.galleryCV.dataSource = self
            self.galleryCV.delegate = self
            self.galleryCV.reloadData()
        }
    }
    
    //Cancel Delegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.isNavigationBarHidden = false
        self.dismiss(animated: true, completion: nil)
    }
}
