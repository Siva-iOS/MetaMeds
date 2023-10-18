//
//  PopupVC.swift
//  MetaMeds
//
//  Created by Ajeeth Kumar on 05/10/23.
//

import UIKit

protocol GenderProto
{
    func GenderResult(Name:String, id: Int)
}
protocol BloodGroupProto
{
    func BloodGroupResult(Name:String, id: Int)
}
protocol LocationProto
{
    func LocationResult(Name:String, id: Int)
}
protocol ReqProto
{
    func ReqResult(Name:String, id: Int)
}
protocol QuantityProto
{
    func QuantityResult(Name:String, id: Int)
}
class PopupVC: UIViewController {

    @IBOutlet weak var background_layout: UIView!
    @IBOutlet weak var bg_layout: UIView!
    
    @IBOutlet weak var popup_table: UITableView!
    
    @IBOutlet weak var popup_tableHeight: NSLayoutConstraint!
    
    var type = ""
    var Genderdelegate : GenderProto!
    var BloodGroupdelegate : BloodGroupProto!
    var Locationdelegate : LocationProto!
    var Reqdelegate : ReqProto!
    var Quantitydelegate : QuantityProto!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        background_layout.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        popup_table.register(UINib(nibName: "PaymentTableCell", bundle: nil), forCellReuseIdentifier: "PaymentTableCell")
        popup_table.tableFooterView = UIView()
        
        if self.type == "Gender"
        {
            GenderData()
        }
        else if self.type == "BG"
        {
            BloodGroupData()
        }
        else if self.type == "Location"
        {
            LocationData()
        }
        else if self.type == "Req"
        {
            ReqData()
        }
        else if self.type == "Quantity"
        {
            QuantityData()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        let touch = touches.first
        if touch?.view == self.background_layout
        {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func GenderData()
    {
//        LoginViewModel.BloodGroupService(param: UploadLoginObj(), Showit: true)
//        {
//            DispatchQueue.main.async
//                {
                    if LoginViewModel.GendersList.count > 10
                    {
                        self.popup_tableHeight.constant = CGFloat(600)
                    }
                    else
                    {
                        self.popup_tableHeight.constant = CGFloat(LoginViewModel.GendersList.count * 60)
                    }
                    self.popup_table.dataSource = self
                    self.popup_table.delegate = self
                    self.popup_table.reloadData()
//                }
//        }
    }
    
    func BloodGroupData()
    {
//        LoginViewModel.BloodGroupService(param: UploadLoginObj(), Showit: true)
//        {
//            DispatchQueue.main.async
//                {
                    if LoginViewModel.BloodList.count > 10
                    {
                        self.popup_tableHeight.constant = CGFloat(600)
                    }
                    else
                    {
                        self.popup_tableHeight.constant = CGFloat(LoginViewModel.BloodList.count * 60)
                    }
                    self.popup_table.dataSource = self
                    self.popup_table.delegate = self
                    self.popup_table.reloadData()
//                }
//        }
    }
    func LocationData()
    {
//        LoginViewModel.BloodGroupService(param: UploadLoginObj(), Showit: true)
//        {
//            DispatchQueue.main.async
//                {
                    if LoginViewModel.LocationsList.count > 10
                    {
                        self.popup_tableHeight.constant = CGFloat(600)
                    }
                    else
                    {
                        self.popup_tableHeight.constant = CGFloat(LoginViewModel.LocationsList.count * 60)
                    }
                    self.popup_table.dataSource = self
                    self.popup_table.delegate = self
                    self.popup_table.reloadData()
//                }
//        }
    }
    func ReqData()
    {
//        LoginViewModel.BloodGroupService(param: UploadLoginObj(), Showit: true)
//        {
//            DispatchQueue.main.async
//                {
                    if LoginViewModel.RequestTypeList.count > 10
                    {
                        self.popup_tableHeight.constant = CGFloat(600)
                    }
                    else
                    {
                        self.popup_tableHeight.constant = CGFloat(LoginViewModel.RequestTypeList.count * 60)
                    }
                    self.popup_table.dataSource = self
                    self.popup_table.delegate = self
                    self.popup_table.reloadData()
//                }
//        }
    }
    
    func QuantityData()
    {
//        LoginViewModel.BloodGroupService(param: UploadLoginObj(), Showit: true)
//        {
//            DispatchQueue.main.async
//                {
                    if LoginViewModel.QuantityList.count > 10
                    {
                        self.popup_tableHeight.constant = CGFloat(600)
                    }
                    else
                    {
                        self.popup_tableHeight.constant = CGFloat(LoginViewModel.QuantityList.count * 60)
                    }
                    self.popup_table.dataSource = self
                    self.popup_table.delegate = self
                    self.popup_table.reloadData()
//                }
//        }
    }
    
}

extension PopupVC : UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if self.type == "Gender"
        {
            return LoginViewModel.GendersList.count
        }
        else if self.type == "BG"
        {
            return LoginViewModel.BloodList.count
        }
        else if self.type == "Location"
        {
            return LoginViewModel.LocationsList.count
        }
        else if self.type == "Req"
        {
            return LoginViewModel.RequestTypeList.count
        }
        else if self.type == "Quantity"
        {
            return LoginViewModel.QuantityList.count
        }
        else
        {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentTableCell", for: indexPath) as! PaymentTableCell
        
        if self.type == "Gender"
        {
            let dict = LoginViewModel.GendersList[indexPath.row]
            cell.payment_name.text = dict.name
        }
        else if self.type == "BG"
        {
            let dict = LoginViewModel.BloodList[indexPath.row]
            cell.payment_name.text = dict.name
        }
        else if self.type == "Location"
        {
            let dict = LoginViewModel.LocationsList[indexPath.row]
            cell.payment_name.text = dict.name
        }
        else if self.type == "Req"
        {
            let dict = LoginViewModel.RequestTypeList[indexPath.row]
            cell.payment_name.text = dict.name
        }
        else if self.type == "Quantity"
        {
            let dict = LoginViewModel.QuantityList[indexPath.row]
            cell.payment_name.text = dict.name
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if self.type == "Gender"
        {
            let dict = LoginViewModel.GendersList[indexPath.row]
            self.Genderdelegate?.GenderResult(Name: dict.name!, id: dict.id!)
        }
        else if self.type == "BG"
        {
            let dict = LoginViewModel.BloodList[indexPath.row]
            self.BloodGroupdelegate?.BloodGroupResult(Name: dict.name!, id: dict.id!)
        }
        else if self.type == "Location"
        {
            let dict = LoginViewModel.LocationsList[indexPath.row]
            self.Locationdelegate?.LocationResult(Name: dict.name!, id: dict.id!)
        }
        else if self.type == "Req"
        {
            let dict = LoginViewModel.RequestTypeList[indexPath.row]
            self.Reqdelegate?.ReqResult(Name: dict.name!, id: dict.id!)
        }
        else if self.type == "Quantity"
        {
            let dict = LoginViewModel.QuantityList[indexPath.row]
            self.Quantitydelegate?.QuantityResult(Name: dict.name!, id: dict.id!)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
       return 60
    }
}

