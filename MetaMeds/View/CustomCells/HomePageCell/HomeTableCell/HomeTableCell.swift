//
//  HomeTableCell.swift
//  MetaMeds
//
//  Created by Ajeeth Kumar on 06/10/23.
//

import UIKit

class HomeTableCell: UITableViewCell {

    @IBOutlet weak var header_lbl: UILabel!
    
    @IBOutlet weak var post_table: UITableView!
    
    @IBOutlet weak var post_tableHeight: NSLayoutConstraint!
    
    var PostList : [PostDataObj] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.post_table.register(UINib.init(nibName: "PostCell", bundle: nil), forCellReuseIdentifier: "PostCell")
        self.post_table.separatorStyle = .none
        post_table.tableFooterView = UIView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func PostCellValues(postList:[PostDataObj])
    {
        self.PostList = postList
        self.post_tableHeight.constant = CGFloat(self.PostList.count * 155)
        self.post_table.dataSource = self
        self.post_table.delegate = self
        self.post_table.reloadData()
    }
}
extension HomeTableCell : UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.PostList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        cell.selectionStyle = .none
        cell.PostCellValues(postList: self.PostList[indexPath.row], showBtn: false)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if UserObject().RetriveObject().data!.step == 1
        {
            let navigate = UIStoryboard.init(name: "Main", bundle: nil)
            let product = navigate.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            product.check = 1
            UIApplication.topViewController()?.navigationController?.pushViewController(product, animated: true)
        }
        else
        {
            let dict = self.PostList[indexPath.row]
            let navigate = UIStoryboard.init(name: "TabBar", bundle: nil)
            let vc = navigate.instantiateViewController(withIdentifier: "DetailsVC") as! DetailsVC
            vc.details = dict
            UIApplication.topViewController()?.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}
