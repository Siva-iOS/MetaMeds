//
//  BannerDataObj.swift
//  MetaMeds
//
//  Created by Ajeeth Kumar on 06/10/23.
//

import UIKit

class BannerDataObj: Codable
{
    var title : String?
    var banner_image : String?
    var banner_desc : String?
    var is_image : String?
    
    enum CodingKeys: String, CodingKey
    {
        case title = "title"
        case banner_image = "banner_image"
        case banner_desc = "banner_desc"
        case is_image = "is_image"
    }
    
    required init(from decoder: Decoder) throws
    {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        banner_image = try values.decodeIfPresent(String.self, forKey: .banner_image)
        banner_desc = try values.decodeIfPresent(String.self, forKey: .banner_desc)
        is_image = try values.decodeIfPresent(String.self, forKey: .is_image)
    }
    
}
