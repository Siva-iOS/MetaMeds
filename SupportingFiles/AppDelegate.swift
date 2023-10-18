//
//  AppDelegate.swift
//  MetaMeds
//
//  Created by Ajeeth Kumar on 04/10/23.
//
import UIKit
import SDWebImage
import IQKeyboardManagerSwift
import GooglePlaces
import Firebase
import FirebaseMessaging

let GoogleMapApiKey = "AIzaSyBR0KsqiqWCiPOQshnI9uZNRYDWwa_1qKk"
let razorKey = "rzp_test_bCOFjCV9WUt7oz"
let UUIDValue = UIDevice.current.identifierForVendor!.uuidString
let ServiceKey = "com.MetaMeds"
let AccountKey = "userdata"
var FCMToken = ""

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, MessagingDelegate{
    
    var window: UIWindow?
    let notificationCenter = UNUserNotificationCenter.current()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if #available(iOS 13.0, *) {
            window?.overrideUserInterfaceStyle = .light
        }
        IQKeyboardManager.shared.enable = true
        GMSPlacesClient.provideAPIKey(GoogleMapApiKey)
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        notificationCenter.delegate = self
        
        if Defaults.GETUSERMODEL() != nil
        {
            let userToken:String = KeychainService.GetUserProfile(service: ServiceKey, account: AccountKey) ?? ""
            
            if !userToken.isEmpty
            {
                if UserObject().RetriveObject().data?.step == 3
                {
                    self.SetRootController(StoryboardName: "TabBar", Identifier: "TabBarVC")
                }
                else
                {
                    self.SetRootController(StoryboardName: "Main", Identifier: "SelectScreenVC")
                }
            }
        }
        
        else
        {
            KeychainService.RemoveUserProfile(service: ServiceKey, account: AccountKey)
        }
        
        if #available(iOS 10.0, *)
        {
            UNUserNotificationCenter.current().delegate = self
            
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options:[.badge, .alert, .sound]) { (granted, error) in
                // Enable or disable features based on authorization.
            }
            application.registerForRemoteNotifications()
        }
        else
        {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        UIApplication.shared.applicationIconBadgeNumber = 0
        
        return true
        
    }
    
    
    func SetRootController(StoryboardName:String,Identifier:String)
     {
         let Home = UIStoryboard(name:StoryboardName, bundle: nil).instantiateViewController(withIdentifier:Identifier)
         let navigationController = UINavigationController.init(rootViewController: Home)
         navigationController.navigationBar.barTintColor = AppTheme().AppColor()
         navigationController.navigationBar.tintColor = UIColor.white
         let appDelegate = UIApplication.shared.delegate as! AppDelegate
         appDelegate.window?.rootViewController = navigationController
     }
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?)
    {
        FCMToken = fcmToken!
        print("Firebase registration token: \(String(describing: fcmToken))")
        let dataDict:[String: String] = ["token": fcmToken ?? ""]
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data)
    {
        Messaging.messaging().apnsToken = deviceToken
        
        Messaging.messaging().token { token, error in
            if let error = error {
                print("Error fetching FCM registration token: \(error)")
            } else if let token = token {
                print("FCM registration token: \(token)")
                FCMToken = token
            }
        }
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any])
    {
        print("didReceiveRemoteNotification>>>>>>>>> ",userInfo)
        
        let OrderID = userInfo["gcm.notification.order_id"] as? String
        let NotificationType = userInfo["gcm.notification.type"] as? String ?? ""
        guard
            let aps = userInfo["aps"] as? NSDictionary,
            let alert = aps["alert"] as? NSDictionary
            else { return }
        let NotificationBody = alert["body"] as! String
        let NotificationTitle = alert["title"] as! String
       
        showLocalNotification(title: NotificationTitle, body: NotificationBody, type: NotificationType , order_id: OrderID ?? "")
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void)
    {
        print("didReceiveRemoteNotificationBackground>>>>>>>>> ",userInfo)
        
        let OrderID = userInfo["gcm.notification.order_id"] as? String
        let NotificationType = userInfo["gcm.notification.type"] as? String ?? ""
        guard
            let aps = userInfo["aps"] as? NSDictionary,
            let alert = aps["alert"] as? NSDictionary
            else { return }
        let NotificationBody = alert["body"] as! String
        let NotificationTitle = alert["title"] as! String
       
        showLocalNotification(title: NotificationTitle, body: NotificationBody, type: NotificationType , order_id: OrderID ?? "")
    }

    func showLocalNotification(title:String,body:String,type:String,order_id:String)
    {
        //creating the notification content
        let content = UNMutableNotificationContent()
        
        
        //adding title, subtitle, body and badge
        content.title = title
        //content.subtitle = "local notification"
        content.body = body
        //content.badge = 1
        content.sound = UNNotificationSound.default
        
        //getting the notification trigger
        //it will be called after 5 seconds
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        
        //getting the notification request
        let request = UNNotificationRequest(identifier: "SimplifiedIOSNotification", content: content, trigger: trigger)
        
        //adding the notification to notification center
        notificationCenter.add(request, withCompletionHandler: nil)
    }
}

@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate
{
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void)
    {
        let userInfo = notification.request.content.userInfo
        
        print("userNotificationCenter>>>>>>>>> ",userInfo)
        
        let NotificationType = userInfo["gcm.notification.type"] as? String ?? ""
        let OrderID = userInfo["gcm.notification.order_id"] as? String
        guard
            let aps = userInfo["aps"] as? NSDictionary,
            let alert = aps["alert"] as? NSDictionary
            else { return }
        let NotificationBody = alert["body"] as! String
        let NotificationTitle = alert["title"] as! String
        
        print("OrderID>>>>>>>> ",OrderID)
        
        showLocalNotification(title: NotificationTitle, body: NotificationBody, type: NotificationType, order_id: OrderID ?? "")
        
        completionHandler([[.alert, .sound]])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void)
    {
        let userInfo = response.notification.request.content.userInfo
       
        print("userNotificationCenterBackground>>>>>>>>> ",userInfo)
            
        let OrderID = userInfo["gcm.notification.order_id"] as? String ?? ""
        let NotificationType = userInfo["gcm.notification.type"] as? String ?? ""
        guard
            let aps = userInfo["aps"] as? NSDictionary,
            let alert = aps["alert"] as? NSDictionary
            else { return }
        let NotificationBody = alert["body"] as! String
        let NotificationTitle = alert["title"] as! String
       
        showLocalNotification(title: NotificationTitle, body: NotificationBody, type: NotificationType , order_id: OrderID)
        
        let tabBar = UIStoryboard(name:"TabBar", bundle: nil).instantiateViewController(withIdentifier:"TabBarVC") as! TabBarVC
        let vc = UINavigationController.init(rootViewController: tabBar)
        tabBar.loadViewIfNeeded()
        tabBar.selectedIndex = 0
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        appdelegate.window?.rootViewController = vc
        
        completionHandler()
    }
}

extension UIDevice {
        var modelName: String {
            var systemInfo = utsname()
            uname(&systemInfo)
            let machineMirror = Mirror(reflecting: systemInfo.machine)
            let identifier = machineMirror.children.reduce("") { identifier, element in
                guard let value = element.value as? Int8, value != 0 else { return identifier }
                return identifier + String(UnicodeScalar(UInt8(value)))
            }
            return identifier
        }
    }
extension UIApplication {
  var statusBarUIView: UIView? {
    if #available(iOS 13.0, *) {
      let tag = 3848245
      let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
      if let statusBar = keyWindow?.viewWithTag(tag) {
        return statusBar
      } else {
        let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
        statusBarView.tag = tag
        keyWindow?.addSubview(statusBarView)
        return statusBarView
      }
    } else {
      if responds(to: Selector(("statusBar"))) {
        return value(forKey: "statusBar") as? UIView
      }
    }
    return nil
  }
}
