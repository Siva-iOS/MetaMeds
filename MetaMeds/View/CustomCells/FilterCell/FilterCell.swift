//
//  FilterCell.swift
//  MetaMeds
//
//  Created by Ajeeth Kumar on 09/10/23.
//

import UIKit

protocol FilterProto
{
    func FilterResult(bgID: Int, km: Int)
}

class FilterCell: UITableViewCell {

    @IBOutlet weak var header_lbl: UILabel!
    
    @IBOutlet weak var filter_collection: UICollectionView!
    
    @IBOutlet weak var filter_collectionHeight: NSLayoutConstraint!
    
    let spacing:CGFloat = 4
    var numberOfItemsPerRow:CGFloat = 2
    let spacingBetweenCells:CGFloat = 4
    
    let spacing1:CGFloat = 12
    let spacingBetweenCells1:CGFloat = 12
    let layout = UICollectionViewFlowLayout()
    
    var type = ""
    var BloodList : [BloodGroupDataObj] = []
    var DistanceList : [BloodGroupDataObj] = []
    var delegate : FilterProto!
    var bloodId = 0
    var distkm = 0

    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.filter_collection.register(UINib.init(nibName: "FilterCollectionCell", bundle: nil), forCellWithReuseIdentifier: "FilterCollectionCell")
        
        self.filter_collection.backgroundColor = UIColor.clear
        
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.scrollDirection = .vertical
        self.filter_collection.collectionViewLayout = layout
        Defaults.SET_BG(BG: 0)
        Defaults.SET_KM(KM: 0)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func FilterCellValues(title:String,num_row:Int,BloodList:[BloodGroupDataObj],DistanceList: [BloodGroupDataObj])
    {
        self.filter_collection.isScrollEnabled = true
        self.numberOfItemsPerRow = CGFloat(num_row)
        self.header_lbl.text = title
        self.type = title
        self.BloodList = BloodList
        self.DistanceList = DistanceList
        
        if self.type == "Blood Type"
        {
            if (self.BloodList.count % 3 == 0)
            {
                self.filter_collectionHeight.constant = CGFloat((self.BloodList.count / 3) * 40) + 20
            }
            if (self.BloodList.count % 3 == 2)
            {
                self.filter_collectionHeight.constant = CGFloat(((self.BloodList.count + 1) / 3) * 40) + 20
            }
            else
            {
                self.filter_collectionHeight.constant = CGFloat(((self.BloodList.count + 2) / 3) * 40) + 20
            }
        }
        else
        {
            if (self.DistanceList.count % 3 == 0)
            {
                self.filter_collectionHeight.constant = CGFloat((self.DistanceList.count / 3) * 40) + 20
            }
            if (self.DistanceList.count % 3 == 2)
            {
                self.filter_collectionHeight.constant = CGFloat(((self.DistanceList.count + 1) / 3) * 40) + 20
            }
            else
            {
                self.filter_collectionHeight.constant = CGFloat(((self.DistanceList.count + 2) / 3) * 40) + 20
            }
        }
        
        self.filter_collection.dataSource = self
        self.filter_collection.delegate = self
        self.filter_collection.reloadData()
    }
}

extension FilterCell : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if self.type == "Blood Type"
        {
            return self.BloodList.count
        }
        else
        {
            return self.DistanceList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterCollectionCell", for: indexPath) as! FilterCollectionCell
        cell.bg_layout.layer.borderWidth = 1
        if self.type == "Blood Type"
        {
            let dict = self.BloodList[indexPath.row]
            cell.CellValues(dict: self.BloodList[indexPath.row])
            if dict.isSelect == 1
            {
                cell.bg_layout.layer.borderColor = UIColor.init(named: "AppColor")?.cgColor
            }
            else
            {
                if #available(iOS 13.0, *) {
                    cell.bg_layout.layer.borderColor = UIColor.systemGray4.cgColor
                } else {
                    // Fallback on earlier versions
                }
            }
            return cell
        }
        else
        {
            let dict = self.DistanceList[indexPath.row]
            cell.CellValues(dict: self.DistanceList[indexPath.row])
            if dict.isSelect == 1
            {
                cell.bg_layout.layer.borderColor = UIColor.init(named: "AppColor")?.cgColor
            }
            else
            {
                if #available(iOS 13.0, *) {
                    cell.bg_layout.layer.borderColor = UIColor.systemGray4.cgColor
                } else {
                    // Fallback on earlier versions
                }
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        if self.type == "Blood Type"
        {
            for value in self.BloodList
            {
                value.isSelect = 0
                
            }
            
            self.BloodList[indexPath.row].isSelect = 1
            self.bloodId = self.BloodList[indexPath.row].id ?? 0
            Defaults.SET_BG(BG: self.BloodList[indexPath.row].id ?? 0)
            filter_collection.dataSource = self
            filter_collection.delegate = self
            filter_collection.reloadData()
        }
        else
        {
            for value in self.DistanceList
            {
                value.isSelect = 0
                
            }
            self.DistanceList[indexPath.row].isSelect = 1
            distkm = self.DistanceList[indexPath.row].km ?? 0
            Defaults.SET_KM(KM: self.BloodList[indexPath.row].id ?? 0)
            filter_collection.dataSource = self
            filter_collection.delegate = self
            filter_collection.reloadData()
        }
        self.delegate.FilterResult(bgID: Defaults.GET_BG()!, km:  Defaults.GET_KM()!)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let totalSpacing = (2 * self.spacing1) + ((numberOfItemsPerRow - 1) * spacingBetweenCells1)
        
        let width = (collectionView.bounds.width - totalSpacing)/numberOfItemsPerRow
        
        return CGSize.init(width: width, height: 40)
        
    }
}
