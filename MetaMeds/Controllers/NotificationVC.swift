//
//  NotificationVC.swift
//  MetaMeds
//
//  Created by Ajeeth Kumar on 09/10/23.
//

import UIKit

class NotificationVC: UIViewController {

    
    @IBOutlet weak var bg_layout: UIView!
    @IBOutlet weak var empty_layout: UIView!
    
    @IBOutlet weak var notification_table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.notification_table.register(UINib(nibName: "NotificationCell", bundle: nil), forCellReuseIdentifier: "NotificationCell")
        self.notification_table.separatorStyle = .none
        ReloadData(lastIndex: 0, isLoad: true)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        bg_layout.roundCorners(corners: [.topLeft, .topRight], radius: 15)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if #available(iOS 13.0, *) {
                let window = UIApplication.shared.windows.first
                let topPadding = window?.safeAreaInsets.top
                let statusBar = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: topPadding ?? 0.0))
            statusBar.backgroundColor = UIColor.init(named: "AppColor")
                UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.addSubview(statusBar)
            }
    }

    @IBAction func back_onClick(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    func ReloadData(lastIndex:Int,isLoad:Bool)
    {
        let upload = UploadViewListObj(user_id: UserObject().RetriveObject().data!.id, pag_no: String(lastIndex))
        
        HomeViewModel.NotificationService(param: upload, header: UploadHeaderObj(Authorization: UserObject().RetriveObject().data!.auth_token!), Showit: true)
        {
            DispatchQueue.main.async
            {
                self.empty_layout.isHidden = true
                self.notification_table.isHidden = false
                self.notification_table.dataSource = self
                self.notification_table.delegate = self
                self.notification_table.reloadData()
            }
        }
    Empty:
        {
            DispatchQueue.main.async
            {
                guard lastIndex == 0
                else{
                    return
                }
                self.empty_layout.isHidden = false
                self.notification_table.isHidden = true
            }
        }
    }
}

extension NotificationVC : UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return HomeViewModel.NoticationList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath) as! NotificationCell
        cell.selectionStyle = .none
        let dict = HomeViewModel.NoticationList[indexPath.row]
        cell.header_lbl.text = dict.title
        cell.content_lbl.text = dict.content
        cell.time_lbl.text = dict.is_date
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        guard indexPath.row == HomeViewModel.NoticationList.count - 1
        else { return }
        self.ReloadData(lastIndex: HomeViewModel.NoticationList.count, isLoad: false)
    }
}
