//
//  ProfileVC.swift
//  MetaMeds
//
//  Created by Ajeeth Kumar on 09/10/23.
//

import UIKit

class ProfileObj: NSObject {

    var profile_icon : UIImage?
    var profile_name : String?
    
    init(profile_icon:UIImage,profile_name:String)
    {
        self.profile_icon = profile_icon
        self.profile_name = profile_name
    }
    
}
class ProfileVC: UIViewController {

    
    @IBOutlet weak var profile_layout: UIView!
    
    @IBOutlet weak var top_layout: UIView!
    
    @IBOutlet weak var profile_img: UIImageView!
    
    @IBOutlet weak var name_lbl: UILabel!
    
    @IBOutlet weak var email_lbl: UILabel!
    
    @IBOutlet weak var profile_table: UITableView!
    
    var profileList : [ProfileObj] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        profile_img.setRounded()
        ApplyShadowView.setCardView(view: top_layout, cornerRadius: 10, setColor: UIColor.white, shadowRadius: 1.5, Shadowopacity: 1.0)
        ApplyShadowView.setCardView(view: profile_table, cornerRadius: 10, setColor: UIColor.white, shadowRadius: 1.5, Shadowopacity: 1.0)
        profile_table.register(UINib(nibName: "ProfileCell", bundle: nil), forCellReuseIdentifier: "ProfileCell")
        profile_table.tableFooterView = UIView()
        profile_table.separatorColor = UIColor.darkGray
        profile_table.separatorStyle = .singleLine
        
        profileList.append(ProfileObj(profile_icon: UIImage.init(named: "hut 1 (3)")!, profile_name: "Home"))
        profileList.append(ProfileObj(profile_icon: UIImage.init(named: "Group (56)")!, profile_name: "Post"))
        profileList.append(ProfileObj(profile_icon: UIImage.init(named: "Group (55)")!, profile_name: "My Request"))
        profileList.append(ProfileObj(profile_icon: UIImage.init(named: "Group (58)")!, profile_name: "Edit Profile"))
        profileList.append(ProfileObj(profile_icon: UIImage.init(named: "image 659")!, profile_name: "Notification"))
        profileList.append(ProfileObj(profile_icon: UIImage.init(named: "share (3) 1 (4)")!, profile_name: "Share"))
        profileList.append(ProfileObj(profile_icon: UIImage.init(named: "rate (4)")!, profile_name: "Rate this App"))
        
        if UserObject().RetriveObject().data!.step == 1
        {
            profileList.append(ProfileObj(profile_icon: UIImage.init(named: "logout (5) (5)")!, profile_name: "Login"))
        }
        else
        {
            profileList.append(ProfileObj(profile_icon: UIImage.init(named: "logout (5) (5)")!, profile_name: "Logout"))
        }
        
        let imageTap = UITapGestureRecognizer.init(target: self, action: #selector(imageAction))
        profile_img.addGestureRecognizer(imageTap)
        
        profile_table.dataSource = self
        profile_table.delegate = self
        profile_table.reloadData()
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
        
        self.name_lbl.text = UserObject().RetriveObject().data!.name ?? "MetaMeds User"
        self.email_lbl.text = UserObject().RetriveObject().data!.email ?? "user@metameds.in"
        self.profile_img.sd_setImage(with: URL.init(string: UserObject().RetriveObject().data!.is_user_profile_image ?? ""))
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        profile_layout.roundCorners(corners: [.topLeft, .topRight], radius: 15)
    }
    
    @IBAction func edit_onClick(_ sender: Any)
    {
        let navigate = UIStoryboard.init(name: "TabBar", bundle: nil)
        let vc = navigate.instantiateViewController(withIdentifier: "EditProfileVC") as! EditProfileVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func imageAction()
    {
        let navigate = UIStoryboard.init(name: "TabBar", bundle: nil)
        let vc = navigate.instantiateViewController(withIdentifier: "EditProfileVC") as! EditProfileVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ProfileVC : UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.profileList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as! ProfileCell
        cell.selectionStyle = .none
        let dict = self.profileList[indexPath.row]
        
        cell.img.image = dict.profile_icon
        cell.name_lbl.text = dict.profile_name
        cell.bg_layout.layer.masksToBounds = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        switch indexPath.row
        {
        case 0:
            let tabBar = UIStoryboard(name:"TabBar", bundle: nil).instantiateViewController(withIdentifier:"TabBarVC") as! TabBarVC
            let vc = UINavigationController.init(rootViewController: tabBar)
            tabBar.loadViewIfNeeded()
            tabBar.selectedIndex = 0
            let appdelegate = UIApplication.shared.delegate as! AppDelegate
            appdelegate.window?.rootViewController = vc
            break
            
        case 1:
            if UserObject().RetriveObject().data!.step == 1
            {
                let navigate = UIStoryboard.init(name: "Main", bundle: nil)
                let product = navigate.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
                product.check = 1
                UIApplication.topViewController()?.navigationController?.pushViewController(product, animated: true)
            }
            else
            {
                let tabBar = UIStoryboard(name:"TabBar", bundle: nil).instantiateViewController(withIdentifier:"TabBarVC") as! TabBarVC
                let vc = UINavigationController.init(rootViewController: tabBar)
                tabBar.loadViewIfNeeded()
                tabBar.selectedIndex = 1
                let appdelegate = UIApplication.shared.delegate as! AppDelegate
                appdelegate.window?.rootViewController = vc
            }
            
            break
            
        case 2:
            if UserObject().RetriveObject().data!.step == 1
            {
                let navigate = UIStoryboard.init(name: "Main", bundle: nil)
                let product = navigate.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
                product.check = 1
                UIApplication.topViewController()?.navigationController?.pushViewController(product, animated: true)
            }
            else
            {
                let navigate = UIStoryboard.init(name: "TabBar", bundle: nil)
                let vc = navigate.instantiateViewController(withIdentifier: "AllRequestVC") as! AllRequestVC
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
            break
            
        case 3:
            if UserObject().RetriveObject().data!.step == 1
            {
                let navigate = UIStoryboard.init(name: "Main", bundle: nil)
                let product = navigate.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
                product.check = 1
                UIApplication.topViewController()?.navigationController?.pushViewController(product, animated: true)
            }
            else
            {
                let navigate = UIStoryboard.init(name: "TabBar", bundle: nil)
                let vc = navigate.instantiateViewController(withIdentifier: "EditProfileVC") as! EditProfileVC
                self.navigationController?.pushViewController(vc, animated: true)
            }
            break
            
        case 4:
        
            let navigate = UIStoryboard.init(name: "TabBar", bundle: nil)
            let product = navigate.instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
            self.navigationController?.pushViewController(product, animated: true)
            break
            
        case 5:
            Toast(message: "Coming Soon", view: self.view)
//            let message = "Hey Dude! Checkout the best app MetaMeds at:"
//
//            //Set the link to share.
//            if let link = NSURL(string: "https://apps.apple.com/in/app/Orbee/id152179152912o")
//            {
//                let objectsToShare = [message,link] as [Any]
//                let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
//                activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
//                self.present(activityVC, animated: true, completion: nil)
//            }
//        case 4:
//            let navigate = UIStoryboard.init(name: "Main2", bundle: nil)
//            let product = navigate.instantiateViewController(withIdentifier: "NotificationVc") as! NotificationVc
//            self.navigationController?.pushViewController(product, animated: true)
//            break
        case 6:
            Toast(message: "Coming Soon", view: self.view)
            
            break
       
        case 7:
            if UserObject().RetriveObject().data!.step == 1
            {
                let navigate = UIStoryboard.init(name: "Main", bundle: nil)
                let product = navigate.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
                product.check = 1
                UIApplication.topViewController()?.navigationController?.pushViewController(product, animated: true)
            }
            else
            {
                ShowLogoutAlert()
            }
            break
        default:
            break
        }
    }
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 60
    }
    
    func ShowLogoutAlert()
    {
        let LogoutAlert = UIAlertController(title: "Are you sure want to logout from MetaMeds?", message: "", preferredStyle: .actionSheet)
        
        let callFunction1 = UIAlertAction(title: "Logout", style: UIAlertAction.Style.destructive, handler: self.Logout)
        
        let callFunction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
        
        LogoutAlert.addAction(callFunction1)
        LogoutAlert.addAction(callFunction)
        
        present(LogoutAlert, animated: true, completion: nil)
    }
    
    func Logout(alert: UIAlertAction)
    {
        let upload = UploadOTPObj(user_id: UserObject().RetriveObject().data!.id)
        LoginViewModel.LogoutService(param: upload, header: UploadHeaderObj(Authorization: UserObject().RetriveObject().data!.auth_token), Showit: true)
        {
            DispatchQueue.main.async
            {
                if let appDomain = Bundle.main.bundleIdentifier
                {
                    UserDefaults.standard.removePersistentDomain(forName: appDomain)
                }
                KeychainService.RemoveUserProfile(service: ServiceKey, account: AccountKey)
                let Home = UIStoryboard(name:"Main", bundle: nil).instantiateViewController(withIdentifier:"SelectScreenVC") as! SelectScreenVC
                self.present(Home, animated: true, completion: {
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.SetRootController(StoryboardName: "Main", Identifier: "SelectScreenVC")
                })
            }
        }
    }
}
