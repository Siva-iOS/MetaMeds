//
//  SearchVC.swift
//  MetaMeds
//
//  Created by Ajeeth Kumar on 09/10/23.
//

import UIKit

class SearchVC: UIViewController {

    
    @IBOutlet weak var bg_layout: UIView!
    
    @IBOutlet weak var filter_btn: UIButton!
    
    @IBOutlet weak var search_layout: UIView!
    
    @IBOutlet weak var search_btn: UIButton!
    @IBOutlet weak var search_txt: UITextField!
    
    @IBOutlet weak var search_table: UITableView!
    
    @IBOutlet weak var empty_layout: UIView!
    
//    var bloodId = 0
//    var distkm = "0"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ApplyShadowView.setCardView(view: search_layout, cornerRadius: 10, setColor: UIColor.white, shadowRadius: 1.5, Shadowopacity: 1.0)
        search_btn.setImage(UIImage.init(named: "Search (1)")?.maskWithColor(color: UIColor.black), for: .normal)
        self.search_table.register(UINib(nibName: "PostCell", bundle: nil), forCellReuseIdentifier: "PostCell")
        self.search_table.separatorStyle = .none
        search_txt.becomeFirstResponder()
        search_txt.delegate = self
        ReloadData(bloodID: 0, km: 0)
    }

    func ReloadData(bloodID : Int, km: Int)
    {
        print(source_latitude)
        let upload = UploadViewListObj(user_id: UserObject().RetriveObject().data!.id, type: 1, blood_group : bloodID, km: km, latitude: source_latitude ,longitude: source_longitude, search_value: search_txt.text)
        
        HomeViewModel.ViewPostService(param: upload, header: UploadHeaderObj(Authorization: UserObject().RetriveObject().data!.auth_token!), Showit: true)
        {
            DispatchQueue.main.async
            {
                self.empty_layout.isHidden = true
                self.search_table.isHidden = false
                self.search_table.dataSource = self
                self.search_table.delegate = self
                self.search_table.reloadData()
            }
        }
    Empty:
        {
            DispatchQueue.main.async
            {
                self.empty_layout.isHidden = false
                self.search_table.isHidden = true
            }
        }
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
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        bg_layout.roundCorners(corners: [.topLeft, .topRight], radius: 15)
    }
    

    @IBAction func back_onClick(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func filter_onClick(_ sender: Any) {
//        search_txt.resignFirstResponder()
        let storyboard = UIStoryboard.init(name: "TabBar", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "FilterVC") as! FilterVC
        vc.delegate = self
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true, completion: nil)
    }
}

extension SearchVC : UITextFieldDelegate
{
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        self.ReloadData(bloodID: 0, km: 0)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        self.ReloadData(bloodID: 0, km: 0)
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        self.ReloadData(bloodID: 0, km: 0)
        return true
    }
}


extension SearchVC : UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return HomeViewModel.ViewPostList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        cell.selectionStyle = .none
        cell.PostCellValues(postList: HomeViewModel.ViewPostList[indexPath.row], showBtn: false)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let dict = HomeViewModel.ViewPostList[indexPath.row]
        let navigate = UIStoryboard.init(name: "TabBar", bundle: nil)
        let vc = navigate.instantiateViewController(withIdentifier: "DetailsVC") as! DetailsVC
        vc.details = dict
       self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 155
    }
}

extension SearchVC: FilterProto
{
    func FilterResult(bgID: Int, km: Int)
    {
        ReloadData(bloodID: bgID, km: km)
    }
}
