//
//  LoginVC.swift
//  MetaMeds
//
//  Created by Ajeeth Kumar on 04/10/23.
//

import UIKit
import CoreLocation

var source_latitude : Double?
var source_longitude : Double?
var LoginViewModel = LoginVM()

class LoginVC: UIViewController , CLLocationManagerDelegate {
    
    
    @IBOutlet weak var back_btn: UIButton!
    
    @IBOutlet weak var BACK_BTN: UIButton!
    @IBOutlet weak var login_layout: UIView!
    
    @IBOutlet weak var mobile_layout: UIView!
    
    @IBOutlet weak var mobile_txt: UITextField!
    
    @IBOutlet weak var login_btn: UIButton!
    
    @IBOutlet weak var guest_btn: UIButton!
    
    var check = 0
    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.requestAlwaysAuthorization()
            // For use in foreground
            self.locationManager.requestWhenInUseAuthorization()
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                self.locationManager.delegate = self
                self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                self.locationManager.startUpdatingLocation()
            }
        }
            
        
        mobile_layout.layer.cornerRadius = 6
        mobile_layout.layer.borderColor = UIColor.systemGray4.cgColor
        mobile_layout.layer.borderWidth = 1
        ApplyShadowView.setCardView(view: login_layout, cornerRadius: 20, setColor: UIColor.white, shadowRadius: 2.5, Shadowopacity: 2.0)
        self.login_btn.layer.cornerRadius = 10
        self.login_btn.layer.masksToBounds = true
        self.guest_btn.layer.cornerRadius = 10
        self.guest_btn.layer.masksToBounds = true
        mobile_txt.maxLength = 10
        
//        if check == 0
//        {
//            self.back_btn.isHidden = true
//            self.BACK_BTN.isHidden = true
//        }
//        else
//        {
//            self.back_btn.isHidden = false
//            self.BACK_BTN.isHidden = false
//        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        source_latitude = locValue.latitude
        source_latitude = locValue.longitude
      }
    
    @IBAction func back_onClick(_ sender: Any)
    {
        if check == 1
        {
            let appdelegate = UIApplication.shared.delegate as! AppDelegate
            appdelegate.SetRootController(StoryboardName: "Main", Identifier: "SelectScreenVC")
        }
        else
        {
            self.navigationController?.popViewController(animated: true)
        }
       
    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func login_onClick(_ sender: Any)
    {
        self.view.endEditing(true)
        if validation()
        {
            let upload = UploadLoginObj(mobile: self.mobile_txt.text, fcm_token: FCMToken, device_type: "iOS", device_id: UUIDValue)
            
            LoginViewModel.LoginService(param: upload, Showit: true)
            {
                DispatchQueue.main.async
                {
                    let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "OTPVC") as! OTPVC
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
    
    
    @IBAction func guest_onClick(_ sender: Any)
    {
        let upload = UploadGuestLoginObj(username: "guestlogin@gmail.com", password: "demo@123", user_type: "GUEST_USER")
        LoginViewModel.GuestLoginService(param: upload, Showit: true)
        {
            DispatchQueue.main.async
            {
                let Home = UIStoryboard(name:"TabBar", bundle: nil).instantiateViewController(withIdentifier:"TabBarVC")
                let navigationController = UINavigationController.init(rootViewController: Home)
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        appDelegate.window?.rootViewController = navigationController
            }
        }
    }
    
        func validation() -> Bool
        {
            self.view.endEditing(true)
            
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
            return true
        }
}
