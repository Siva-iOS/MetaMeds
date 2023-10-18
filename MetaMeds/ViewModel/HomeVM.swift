//
//  HomeVM.swift
//  MetaMeds
//
//  Created by Ajeeth Kumar on 06/10/23.
//

import UIKit

class HomeVM
{
    var HomeFeedList : HomeFeedDataObj?
    var ViewPostList : [PostDataObj] = []
    var NoticationList : [NotificationDataObj] = []
    
    func HomeFeedService(param:UploadOTPObj,header:UploadHeaderObj,Showit:Bool, sucess:@escaping()-> Void)
    {
        JsonHandler.jsonParsing(webservice: Webservices.HomeContent, params: param, headers: header.dictionaryRepresentation, showIt: Showit, ResponseSucess: { (response) in
            
            do
            {
                let jsonValues = try JSONDecoder().decode(HomeFeedResponseObj.self, from: response)
                
                if jsonValues.status == 1
                {
                    self.HomeFeedList = jsonValues.data!
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
            }
            catch
            {
                print(error)
                print("HomeFeedService???????")
            }
            
        }) { (error) in
            
        }
    }
        func CreatePostService(param:[String:AnyObject],mediaparam:String,mediaData:[Data], header:UploadHeaderObj, Showit:Bool, sucess:@escaping()-> Void)
    {
        JsonHandler.multipartMultiImageParsing(webservice: Webservices.CreatePost, params: param, mediaParam: mediaparam, mediaData: mediaData, headers: header.dictionaryRepresentation, showIt: true) { (response) in
            
            do
            {
                    let jsonValues = try JSONDecoder().decode(CreatePostResponseObj.self, from: response)
    
                    if jsonValues.status == 1
                    {
                        DispatchQueue.main.async
                        {
                            Toast(message: jsonValues.message ?? "", view: UIApplication.topViewController()!.view)
                        }
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
                            Toast(message: "Session Expired", view: UIApplication.topViewController()!.view)
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
                print("CreatePostService???????")
            }
            
        } failure: { (empty) in
            
        } error: { (error) in
            
        }
    }
    
    func ViewPostService(param:UploadViewListObj,header:UploadHeaderObj,Showit:Bool, sucess:@escaping()-> Void,Empty:@escaping()-> Void)
    {
        JsonHandler.jsonParsing(webservice: Webservices.GetPost, params: param, headers: header.dictionaryRepresentation, showIt: Showit, ResponseSucess: { (response) in
            
            do
            {
                let jsonValues = try JSONDecoder().decode(ViewPostResponseObj.self, from: response)
                
                if jsonValues.status == 1
                {
                    self.ViewPostList = jsonValues.data ?? []
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
                        Toast(message: "Session Expired", view: UIApplication.topViewController()!.view)
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
                    Empty()
                }
                
            }
            catch
            {
                print(error)
                print("ViewPostService???????")
            }
            
        }) { (error) in
            
        }
    }
    
    func NotificationService(param:UploadViewListObj,header:UploadHeaderObj,Showit:Bool, sucess:@escaping()-> Void,Empty:@escaping()-> Void)
    {
        JsonHandler.jsonParsing(webservice: Webservices.Notification, params: param, headers: header.dictionaryRepresentation, showIt: Showit, ResponseSucess: { (response) in
            
            do
            {
                let jsonValues = try JSONDecoder().decode(NotificationResponseObj.self, from: response)
                
                if jsonValues.status == 1
                {
                    param.pag_no == "0" ? self.NoticationList.removeAll():nil
                    for value in jsonValues.data!
                    {
                        self.NoticationList.append(value)
                    }
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
                        Toast(message: "Session Expired", view: UIApplication.topViewController()!.view)
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
                    Empty()
                }
                
            }
            catch
            {
                print(error)
                print("NotificationService???????")
            }
            
        }) { (error) in
            
        }
    }
    
    func ProfilePicService(param:[String:AnyObject],upload:[String:Data],header:UploadHeaderObj, Showit:Bool, sucess:@escaping()-> Void)
    {
        JsonHandler.multipartParsing(webservice: Webservices.ProfilePic, params: param, mediaData: upload, headers: header.dictionaryRepresentation, showIt: true, sucess: { (response) in
            
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
            }
            catch
            {
                print("ProfilePicService???????")
            }
            
        }, failure: { (empty) in
            
        }) { (error) in
            
        }
    }
    
    func RatingService(param:UploadRatingObj,header:UploadHeaderObj,Showit:Bool, sucess:@escaping()-> Void)
    {
        JsonHandler.jsonParsing(webservice: Webservices.Rating, params: param, headers: header.dictionaryRepresentation, showIt: Showit, ResponseSucess: { (response) in
            
            do
            {
                let jsonValues = try JSONDecoder().decode(RatingResponseObj.self, from: response)
                
                if jsonValues.status == 1
                {
                    DispatchQueue.main.async
                    {
                        Toast(message: jsonValues.message!, view: UIApplication.topViewController()!.view)
                    }
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
                        Toast(message: "Session Expired", view: UIApplication.topViewController()!.view)
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
                   
                }
                
            }
            catch
            {
                print(error)
                print("ViewPostService???????")
            }
            
        }) { (error) in
            
        }
    }

}
