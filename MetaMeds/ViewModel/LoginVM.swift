//
//  LoginVM.swift
//  MetaMeds
//
//  Created by Ajeeth Kumar on 05/10/23.
//

import UIKit

class LoginVM {
    
    var BloodList : [BloodGroupDataObj] = []
    var GendersList : [BloodGroupDataObj] = []
    var RequestTypeList : [BloodGroupDataObj] = []
    var LocationsList : [BloodGroupDataObj] = []
    var DistanceList : [BloodGroupDataObj] = []
    var QuantityList : [BloodGroupDataObj] = []
    
    func LoginService(param:UploadLoginObj,Showit:Bool, Loginsucess:@escaping()-> Void)
    {
        JsonHandler.jsonParsing(webservice: Webservices.Login, params: param, headers: nil, showIt: Showit, ResponseSucess: { (response) in
            
            do
            {
                let jsonValues = try JSONDecoder().decode(UserResponseObj.self, from: response)
                
                if jsonValues.status == 1
                {
                    KeychainService.RemoveUserProfile(service: ServiceKey, account: AccountKey)
                    let encoded = try JSONEncoder().encode(jsonValues)
                    UserObject().SaveUserObject(Obj: encoded)
                    Loginsucess()
                }
                else if jsonValues.status == 4
                {
                    DispatchQueue.main.async
                        {
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let myAlert = storyboard.instantiateViewController(withIdentifier: "UnderMaintananceVc") as! UnderMaintananceVc
                        myAlert.modalPresentationStyle = .overCurrentContext
                        UIApplication.topViewController()!.present(myAlert, animated: false, completion: nil)
                    }
                }
                else{
                    DispatchQueue.main.async
                        {
                    Toast(message: jsonValues.message!, view: UIApplication.topViewController()!.view)
                    }
                }
            }
            catch
            {
                print("Login???????")
            }
           
        }) { (error) in
            
        }
    }
    
    func GuestLoginService(param:UploadGuestLoginObj,Showit:Bool, sucess:@escaping()-> Void)
    {
        JsonHandler.jsonParsing(webservice: Webservices.GuestLogin, params: param, headers: nil, showIt: Showit, ResponseSucess: { (response) in
            
            do
            {
                let jsonValues = try JSONDecoder().decode(UserResponseObj.self, from: response)
                
                if jsonValues.status == 1 || jsonValues.status == 2
                {
                    KeychainService.RemoveUserProfile(service: ServiceKey, account: AccountKey)
                    let encoded = try JSONEncoder().encode(jsonValues)
                    UserObject().SaveUserObject(Obj: encoded)
                    sucess()
                }
                else if jsonValues.status == 4
                {
                    DispatchQueue.main.async
                        {
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let myAlert = storyboard.instantiateViewController(withIdentifier: "UnderMaintananceVc") as! UnderMaintananceVc
                        myAlert.modalPresentationStyle = .overCurrentContext
                        UIApplication.topViewController()!.present(myAlert, animated: false, completion: nil)
                    }
                }
            }
            catch
            {
                print("GuestLoginService???????")
            }
           
        }) { (error) in
            
        }
    }
    
    func OTPService(param:UploadOTPObj,Showit:Bool, sucess:@escaping()-> Void)
    {
        JsonHandler.jsonParsing(webservice: Webservices.VerifyOtp, params: param, headers: nil, showIt: Showit, ResponseSucess: { (response) in
            
            do
            {
                let jsonValues = try JSONDecoder().decode(UserResponseObj.self, from: response)
                
                if jsonValues.status == 1
                {
                    KeychainService.RemoveUserProfile(service: ServiceKey, account: AccountKey)
                    let encoded = try JSONEncoder().encode(jsonValues)
                    UserObject().SaveUserObject(Obj: encoded)
                    sucess()
                }
                else if jsonValues.status == 4
                {
                    DispatchQueue.main.async
                        {
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let myAlert = storyboard.instantiateViewController(withIdentifier: "UnderMaintananceVc") as! UnderMaintananceVc
                        myAlert.modalPresentationStyle = .overCurrentContext
                        UIApplication.topViewController()!.present(myAlert, animated: false, completion: nil)
                    }
                }
                else{
                    DispatchQueue.main.async
                        {
                    Toast(message: jsonValues.message!, view: UIApplication.topViewController()!.view)
                    }
                }
            }
            catch
            {
                print("OTP???????")
            }
           
        }) { (error) in
            
        }
    }
    func ResendOTPService(param:UploadOTPObj,Showit:Bool, sucess:@escaping()-> Void)
    {
        JsonHandler.jsonParsing(webservice: Webservices.ResendOTP, params: param, headers: nil, showIt: Showit, ResponseSucess: { (response) in
            
            do
            {
                let jsonValues = try JSONDecoder().decode(ResponseObj.self, from: response)
                
                if jsonValues.status == 1
                {
                    DispatchQueue.main.async
                        {
                    Toast(message: jsonValues.message!, view: UIApplication.topViewController()!.view)
                    }
                    sucess()
                }
                else if jsonValues.status == 4
                {
                    DispatchQueue.main.async
                        {
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let myAlert = storyboard.instantiateViewController(withIdentifier: "UnderMaintananceVc") as! UnderMaintananceVc
                        myAlert.modalPresentationStyle = .overCurrentContext
                        UIApplication.topViewController()!.present(myAlert, animated: false, completion: nil)
                    }
                }
                else{
                    DispatchQueue.main.async
                        {
                    Toast(message: jsonValues.message!, view: UIApplication.topViewController()!.view)
                    }
                }
            }
            catch
            {
                print("ResendOTP???????")
            }
           
        }) { (error) in
            
        }
    }
    
    func UpdateProfileService(param:UploadUpdateProfileObj,header:UploadHeaderObj,Showit:Bool, sucess:@escaping()-> Void)
    {
        JsonHandler.jsonParsing(webservice: Webservices.UpdateProfile, params: param, headers: header.dictionaryRepresentation, showIt: Showit, ResponseSucess: { (response) in
            
            do
            {
                let jsonValues = try JSONDecoder().decode(UserResponseObj.self, from: response)
                
                if jsonValues.status == 1
                {
                    KeychainService.RemoveUserProfile(service: ServiceKey, account: AccountKey)
                    let encoded = try JSONEncoder().encode(jsonValues)
                    UserObject().SaveUserObject(Obj: encoded)
                    sucess()
                }
                if jsonValues.status == 2
                {
                    KeychainService.RemoveUserProfile(service: ServiceKey, account: AccountKey)
                    let encoded = try JSONEncoder().encode(jsonValues)
                    UserObject().SaveUserObject(Obj: encoded)
                    sucess()
                }
                else if jsonValues.status == 3
                {
                    DispatchQueue.main.async
                        {
                        if let appDomain = Bundle.main.bundleIdentifier
                        {
                            UserDefaults.standard.removePersistentDomain(forName: appDomain)
                        }
                        KeychainService.RemoveUserProfile(service: ServiceKey, account: AccountKey)
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        appDelegate.SetRootController(StoryboardName: "Main", Identifier: "LoginVC")
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0)
                            {
                        Toast(message: jsonValues.message!, view: UIApplication.topViewController()!.view)
                        }
                    }
                }
                
                else if jsonValues.status == 4
                {
                    DispatchQueue.main.async
                        {
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let myAlert = storyboard.instantiateViewController(withIdentifier: "UnderMaintananceVc") as! UnderMaintananceVc
                        myAlert.modalPresentationStyle = .overCurrentContext
                        UIApplication.topViewController()!.present(myAlert, animated: false, completion: nil)
                    }
                }
                else
                {
                    DispatchQueue.main.async
                        {
                            Toast(message: jsonValues.message!, view: UIApplication.topViewController()!.view)
                        }
                }
            }
            catch
            {
                print("UpdateProfileService???????")
            }
           
        }) { (error) in
            
        }
    }
    
    func EditProfileService(param:UploadUpdateProfileObj,header:UploadHeaderObj,Showit:Bool, sucess:@escaping()-> Void)
    {
        JsonHandler.jsonParsing(webservice: Webservices.EditProfile, params: param, headers: header.dictionaryRepresentation, showIt: Showit, ResponseSucess: { (response) in
            
            do
            {
                let jsonValues = try JSONDecoder().decode(UserResponseObj.self, from: response)
                
                if jsonValues.status == 1
                {
                    KeychainService.RemoveUserProfile(service: ServiceKey, account: AccountKey)
                    let encoded = try JSONEncoder().encode(jsonValues)
                    UserObject().SaveUserObject(Obj: encoded)
                    sucess()
                }
                if jsonValues.status == 2
                {
                    KeychainService.RemoveUserProfile(service: ServiceKey, account: AccountKey)
                    let encoded = try JSONEncoder().encode(jsonValues)
                    UserObject().SaveUserObject(Obj: encoded)
                    sucess()
                }
                else if jsonValues.status == 3
                {
                    DispatchQueue.main.async
                        {
                        if let appDomain = Bundle.main.bundleIdentifier
                        {
                            UserDefaults.standard.removePersistentDomain(forName: appDomain)
                        }
                        KeychainService.RemoveUserProfile(service: ServiceKey, account: AccountKey)
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        appDelegate.SetRootController(StoryboardName: "Main", Identifier: "LoginVC")
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0)
                            {
                        Toast(message: jsonValues.message!, view: UIApplication.topViewController()!.view)
                        }
                    }
                }
                
                else if jsonValues.status == 4
                {
                    DispatchQueue.main.async
                        {
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let myAlert = storyboard.instantiateViewController(withIdentifier: "UnderMaintananceVc") as! UnderMaintananceVc
                        myAlert.modalPresentationStyle = .overCurrentContext
                        UIApplication.topViewController()!.present(myAlert, animated: false, completion: nil)
                    }
                }
                else
                {
                    DispatchQueue.main.async
                        {
                            Toast(message: jsonValues.message!, view: UIApplication.topViewController()!.view)
                        }
                }
            }
            catch
            {
                print("EditProfileService???????")
            }
           
        }) { (error) in
            
        }
    }
    
    func BloodGroupService(param:UploadLoginObj, Showit:Bool, sucess:@escaping()-> Void)
    {
        JsonHandler.jsonParsing(webservice: Webservices.BloodGroupList, params: param, headers: nil, showIt: true, ResponseSucess: { (response) in
            
            do
            {
                let jsonValues = try JSONDecoder().decode(BloodGroupResponseObj.self, from: response)
                
                if jsonValues.status == 1
                {
                    self.BloodList = jsonValues.blood_groups ?? []
                    self.GendersList = jsonValues.genders ?? []
                    self.RequestTypeList = jsonValues.request_types ?? []
                    self.LocationsList = jsonValues.locations ?? []
                    self.DistanceList = jsonValues.distance ?? []
                    self.QuantityList = jsonValues.blood_unit ?? []
                    sucess()
                }
            }
            catch
            {
                print(error)
                print("BloodGroupService???????")
            }
            
        }) { (error) in
            
        }
    }

    
    func LogoutService(param:UploadOTPObj,header:UploadHeaderObj,Showit:Bool, sucess:@escaping()-> Void)
    {
        JsonHandler.jsonParsing(webservice: Webservices.Logout, params: param, headers: header.dictionaryRepresentation, showIt: Showit, ResponseSucess: { (response) in
            
            do
            {
                let jsonValues = try JSONDecoder().decode(ResponseObj.self, from: response)
                
                if jsonValues.status == 1
                {
                    sucess()
                }
            }
            catch
            {
                print("LogoutService???????")
            }
           
        }) { (error) in
            
        }
    }
}
