//
//  HomeBannerCell.swift
//  MetaMeds
//
//  Created by Ajeeth Kumar on 06/10/23.
//

import UIKit
import FSPagerView

class HomeBannerCell: UITableViewCell {
    @IBOutlet weak var pagerView: FSPagerView!{
        didSet {
            self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        }
    }
    
    var BannerList : [BannerDataObj] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        self.pagerView.layer.cornerRadius = 8
    }

    func cellValues(BannerList:[BannerDataObj])
    {
        self.BannerList = BannerList
        self.pagerView.isInfinite = true
        self.pagerView.automaticSlidingInterval = 3.0
        self.pagerView.delegate = self
        self.pagerView.dataSource = self
        self.pagerView.reloadData()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension HomeBannerCell : FSPagerViewDataSource,FSPagerViewDelegate
{
    func numberOfItems(in pagerView: FSPagerView) -> Int
    {
        return self.BannerList.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell
    {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        let dict = BannerList[index]
        cell.imageView?.clipsToBounds = true
        cell.isUserInteractionEnabled = true
        cell.imageView?.sd_setImage(with: URL.init(string: dict.is_image ?? ""))
        return cell
    }


}
