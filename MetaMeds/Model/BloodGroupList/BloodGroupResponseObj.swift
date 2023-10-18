//
//  BloodGroupResponseObj.swift
//  MetaMeds
//
//  Created by Ajeeth Kumar on 05/10/23.
//

import UIKit

class BloodGroupResponseObj: Codable
{
    var status : Int?
    var blood_groups : [BloodGroupDataObj]?
    var genders : [BloodGroupDataObj]?
    var request_types : [BloodGroupDataObj]?
    var locations : [BloodGroupDataObj]?
    var distance : [BloodGroupDataObj]?
    var blood_unit : [BloodGroupDataObj]?
    var message : String?
    
    enum CodingKeys: String, CodingKey
    {
        case status = "status"
        case blood_groups = "blood_groups"
        case genders = "genders"
        case request_types = "request_types"
        case locations = "locations"
        case distance = "distance"
        case blood_unit = "blood_unit"
        case message = "message"
    }
    
    required init(from decoder: Decoder) throws
    {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        blood_groups = try values.decodeIfPresent([BloodGroupDataObj].self, forKey: .blood_groups)
        genders = try values.decodeIfPresent([BloodGroupDataObj].self, forKey: .genders)
        request_types = try values.decodeIfPresent([BloodGroupDataObj].self, forKey: .request_types)
        locations = try values.decodeIfPresent([BloodGroupDataObj].self, forKey: .locations)
        distance = try values.decodeIfPresent([BloodGroupDataObj].self, forKey: .distance)
        blood_unit = try values.decodeIfPresent([BloodGroupDataObj].self, forKey: .blood_unit)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }
}
