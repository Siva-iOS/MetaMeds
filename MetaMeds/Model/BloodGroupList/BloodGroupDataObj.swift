//
//  BloodGroupDataObj.swift
//  MetaMeds
//
//  Created by Ajeeth Kumar on 05/10/23.
//

import UIKit

class BloodGroupDataObj: Codable
{
    var id : Int?
    var name : String?
    var km : Int?
    var isSelect = 0
    
    enum CodingKeys: String, CodingKey
    {
        case id = "id"
        case name = "name"
        case km = "km"
        case isSelect = "isSelect"
    }
    
    required init(from decoder: Decoder) throws
    {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        km = try values.decodeIfPresent(Int.self, forKey: .km)
        isSelect = try values.decodeIfPresent(Int.self, forKey: .isSelect) ?? 0
    }
}

