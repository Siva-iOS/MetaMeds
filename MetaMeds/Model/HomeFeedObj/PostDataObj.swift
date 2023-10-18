//
//  PostDataObj.swift
//  MetaMeds
//
//  Created by Ajeeth Kumar on 06/10/23.
//

import UIKit

class PostDataObj: Codable {
    var id : Int?
    var patient_name : String?
    var dob : String?
    var blood_group : Int?
    var request_date : String?
    var address : String?
    var mobile : String?
    var is_image : String?
    var is_blood_group : String?
    var is_request_date : String?
    var age : String?
    var is_critical : Int?
    
    enum CodingKeys: String, CodingKey
    {
        case id = "id"
        case patient_name = "patient_name"
        case dob = "dob"
        case blood_group = "blood_group"
        case request_date = "request_date"
        case address = "address"
        case mobile = "mobile"
        case is_image = "is_image"
        case is_blood_group = "is_blood_group"
        case is_request_date = "is_request_date"
        case age = "age"
        case is_critical = "is_critical"

    }
    
    required init(from decoder: Decoder) throws
    {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        patient_name = try values.decodeIfPresent(String.self, forKey: .patient_name)
        dob = try values.decodeIfPresent(String.self, forKey: .dob)
        blood_group = try values.decodeIfPresent(Int.self, forKey: .blood_group)
        request_date = try values.decodeIfPresent(String.self, forKey: .request_date)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        is_image = try values.decodeIfPresent(String.self, forKey: .is_image)
        is_blood_group = try values.decodeIfPresent(String.self, forKey: .is_blood_group)
        is_request_date = try values.decodeIfPresent(String.self, forKey: .is_request_date)
        age = try (values.decodeIfPresent(String.self, forKey: .age))
        is_critical = try (values.decodeIfPresent(Int.self, forKey: .is_critical))
    }
}
