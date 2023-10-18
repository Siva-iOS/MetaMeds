//
//  HomeVC.swift
//  MetaMeds
//
//  Created by Ajeeth Kumar on 06/10/23.
//

import UIKit
import CoreLocation

let HomeViewModel = HomeVM()

class HomeVC: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var search_btn: UIButton!
    
    @IBOutlet weak var profile_img: UIImageView!
    
    @IBOutlet weak var home_table: UITableView!
    
    @IBOutlet weak var bg_layout: UIView!
    
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
        
        self.home_table.register(UINib(nibName: "HomeBannerCell", bundle: nil), forCellReuseIdentifier: "HomeBannerCell")
        self.home_table.register(UINib(nibName: "HomeTableCell", bundle: nil), forCellReuseIdentifier: "HomeTableCell")
        profile_img.setRounded()
       
        let imageTap = UITapGestureRecognizer.init(target: self, action: #selector(imageAction))
        profile_img.addGestureRecognizer(imageTap)
        ReloadData()
        BloodGroupData()
    }
    private func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if (status == CLAuthorizationStatus.denied) {
            // The user denied authorization
        } else if (status == CLAuthorizationStatus.authorizedAlways) {
            // The user accepted authorization
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        source_latitude = locValue.latitude
        source_longitude = locValue.longitude
      }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        bg_layout.roundCorners(corners: [.topLeft, .topRight], radius: 15)
    }
    
    @objc func imageAction()
    {
        if UserObject().RetriveObject().data!.step == 1
        {
            let navigate = UIStoryboard.init(name: "Main", bundle: nil)
            let product = navigate.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            product.check = 1
            self.navigationController?.pushViewController(product, animated: true)
        }
        else
        {
            let tabBar = UIStoryboard(name:"TabBar", bundle: nil).instantiateViewController(withIdentifier:"TabBarVC") as! TabBarVC
            let vc = UINavigationController.init(rootViewController: tabBar)
            tabBar.loadViewIfNeeded()
            tabBar.selectedIndex = 3
            let appdelegate = UIApplication.shared.delegate as! AppDelegate
            appdelegate.window?.rootViewController = vc
        }
    }

    @IBAction func search_onClick(_ sender: Any)
    {
        if UserObject().RetriveObject().data!.step == 1
        {
            let navigate = UIStoryboard.init(name: "Main", bundle: nil)
            let product = navigate.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            product.check = 1
            self.navigationController?.pushViewController(product, animated: true)
        }
        else
        {
            let navigate = UIStoryboard.init(name: "TabBar", bundle: nil)
            let vc = navigate.instantiateViewController(withIdentifier: "SearchVC") as! SearchVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
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
    
    func ReloadData()
    {
        let upload = UploadOTPObj(user_id: UserObject().RetriveObject().data!.id)
        
        HomeViewModel.HomeFeedService(param: upload, header: UploadHeaderObj(Authorization: UserObject().RetriveObject().data!.auth_token!), Showit: true)
        {
            DispatchQueue.main.async
            {
                self.home_table.dataSource = self
                self.home_table.delegate = self
                self.home_table.reloadData()
            }
        }
    }
    
     override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = true
        self.profile_img.sd_setImage(with: URL.init(string: UserObject().RetriveObject().data!.is_user_profile_image ?? ""))
         if #available(iOS 13.0, *) {
                 let window = UIApplication.shared.windows.first
                 let topPadding = window?.safeAreaInsets.top
                 let statusBar = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: topPadding ?? 0.0))
             statusBar.backgroundColor = UIColor.init(named: "AppColor")
                 UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.addSubview(statusBar)
             }
    }
    
    
}
extension HomeVC : UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if indexPath.row == 0
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeBannerCell", for: indexPath) as! HomeBannerCell
            
            cell.cellValues(BannerList: (HomeViewModel.HomeFeedList?.banners!)!)
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableCell", for: indexPath) as! HomeTableCell
            cell.PostCellValues(postList: (HomeViewModel.HomeFeedList?.post!)!)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableView.automaticDimension
    }
}
