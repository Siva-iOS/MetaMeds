//
//  TabBarVC.swift
//  Orbee
//
//  Created by Smarthermacmini1 on 16/02/22.
//

import UIKit

class TabBarVC: UITabBarController,UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        UITabBar.appearance().tintColor = UIColor.init(named: "AppColor")
    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = true
    }
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool
    {
            let selectedIndex = tabBarController.viewControllers?.firstIndex(of: viewController)!
        
        if selectedIndex == 0{
            //Do any thing.
            let tabBar = UIStoryboard(name:"TabBar", bundle: nil).instantiateViewController(withIdentifier:"TabBarVC") as! TabBarVC
            let vc = UINavigationController.init(rootViewController: tabBar)
            tabBar.loadViewIfNeeded()
            tabBar.selectedIndex = 0
            let appdelegate = UIApplication.shared.delegate as! AppDelegate
            appdelegate.window?.rootViewController = vc
            return false
        }
        
        else if selectedIndex == 1{
            //Do any thing.
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
            return false
        }
        
        else if selectedIndex == 2{
            //Do any thing.
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
                tabBar.selectedIndex = 2
                let appdelegate = UIApplication.shared.delegate as! AppDelegate
                appdelegate.window?.rootViewController = vc
            }
            return false
        }
    else if selectedIndex == 3{
        //Do any thing.
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
            tabBar.selectedIndex = 3
            let appdelegate = UIApplication.shared.delegate as! AppDelegate
            appdelegate.window?.rootViewController = vc
        }
        return false
    }
        return true
}
            

}
