//
//  ViewRequestVC.swift
//  MetaMeds
//
//  Created by Ajeeth Kumar on 06/10/23.
//

import UIKit

class ViewRequestVC: UIViewController {

    @IBOutlet weak var request_table: UITableView!
    
    @IBOutlet weak var empty_layout: UIView!
    
    @IBOutlet weak var bg_layout: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.request_table.register(UINib(nibName: "PostCell", bundle: nil), forCellReuseIdentifier: "PostCell")
        self.request_table.separatorStyle = .none
        ReloadData()
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
        ReloadData()
    }

    func ReloadData()
    {
        let upload = UploadViewListObj(user_id: UserObject().RetriveObject().data!.id, type: 2)
        
        HomeViewModel.ViewPostService(param: upload, header: UploadHeaderObj(Authorization: UserObject().RetriveObject().data!.auth_token!), Showit: true)
        {
            DispatchQueue.main.async
            {
                self.empty_layout.isHidden = true
                self.request_table.isHidden = false
                self.request_table.dataSource = self
                self.request_table.delegate = self
                self.request_table.reloadData()
            }
        }
    Empty:
        {
            DispatchQueue.main.async
            {
                self.empty_layout.isHidden = false
                self.request_table.isHidden = true
            }
        }
    }
}

extension ViewRequestVC : UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return HomeViewModel.ViewPostList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        cell.selectionStyle = .none
        cell.PostCellValues(postList: HomeViewModel.ViewPostList[indexPath.row], showBtn: true)
        cell.received_btn.addTarget(self, action: #selector(receiveOnClick), for: .touchUpInside)
        cell.received_btn.isUserInteractionEnabled = true
        cell.received_btn.tag = indexPath.row
        return cell
    }
    @objc func receiveOnClick(sender: UIButton)
    {
        let storyboard = UIStoryboard.init(name: "TabBar", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "RequestPopupVC") as! RequestPopupVC
        vc.reqID = HomeViewModel.ViewPostList[sender.tag].id ?? 0
        vc.modalPresentationStyle = .overCurrentContext
        UIApplication.topViewController()?.navigationController?.present(vc, animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let dict = HomeViewModel.ViewPostList[indexPath.row]
        let navigate = UIStoryboard.init(name: "TabBar", bundle: nil)
        let vc = navigate.instantiateViewController(withIdentifier: "DetailsVC") as! DetailsVC
        vc.details = dict
       self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
