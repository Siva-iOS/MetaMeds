//
//  FilterVC.swift
//  MetaMeds
//
//  Created by Ajeeth Kumar on 09/10/23.
//

import UIKit


class FilterVC: UIViewController {

    
    @IBOutlet weak var bg_layout: UIView!
    
    @IBOutlet weak var filter_layout: UIView!
    
    @IBOutlet weak var filter_table: UITableView!
    
    @IBOutlet weak var filter_tableHeight: NSLayoutConstraint!
    @IBOutlet weak var apply_btn: UIButton!
    
    @IBOutlet weak var cancel_btn: UIButton!
    
    var delegate : FilterProto!
    var bloodId = 0
    var distkm = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()

        bg_layout.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        self.apply_btn.layer.cornerRadius = 10
        self.apply_btn.layer.masksToBounds = true
        self.cancel_btn.layer.cornerRadius = 10
        self.cancel_btn.layer.masksToBounds = true
        self.cancel_btn.layer.borderWidth = 1
        self.cancel_btn.layer.borderColor = UIColor.darkGray.cgColor
        BloodGroupData()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        filter_layout.roundCorners(corners: [.topLeft, .topRight], radius: 30)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        let touch = touches.first
        if touch?.view == self.bg_layout
        {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func BloodGroupData()
    {
        LoginViewModel.BloodGroupService(param: UploadLoginObj(), Showit: true)
        {
            DispatchQueue.main.async
                {
                    self.filter_table.register(UINib(nibName: "FilterCell", bundle: nil), forCellReuseIdentifier: "FilterCell")
                    self.filter_table.dataSource = self
                    self.filter_table.delegate = self
                    self.filter_table.reloadData()
                }
        }
    }


    @IBAction func apply_onClick(_ sender: Any)
    {
        print(bloodId)
        delegate.FilterResult(bgID: bloodId, km: distkm)
        self.dismiss(animated: true)
    }
    
    @IBAction func cancel_onClick(_ sender: Any)
    {
        self.dismiss(animated: true)
    }
    
}
extension FilterVC : UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilterCell", for: indexPath) as! FilterCell
        
        if indexPath.row == 0
        {
            cell.FilterCellValues(title: "Blood Type", num_row: 3, BloodList: LoginViewModel.BloodList, DistanceList: LoginViewModel.DistanceList)
            cell.delegate = self
            return cell
        }
        else
        {
            print(LoginViewModel.DistanceList.count)
            cell.FilterCellValues(title: "Distance", num_row: 3, BloodList: LoginViewModel.BloodList, DistanceList: LoginViewModel.DistanceList)
            cell.delegate = self
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableView.automaticDimension
    }
}

extension FilterVC: FilterProto
{
    func FilterResult(bgID: Int, km: Int) {
        self.bloodId = bgID
        self.distkm = km
        print(bloodId)
    }
}
