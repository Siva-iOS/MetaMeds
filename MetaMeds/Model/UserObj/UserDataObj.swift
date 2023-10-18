//
//  UserDataObj.swift
//  GFA Ecommerce
//
//  Created by Smarthermacmini on 31/07/20.
//  Copyright © 2020 Smarthermacmini. All rights reserved.
//

import UIKit

class UserDataObj: Codable
{
    var id : Int?
    var step : Int?
    var name : String?
    var email : String?
    var mobile : String?
    var pincode_id : String?
    var gender : Int?
    var dob : String?
    var blood_group : Int?
    var member_code : String?
    var is_otp_verified : String?
    var auth_token : String?
    var last_login_date : String?
    var is_user_profile_image : String?
    var is_blood_group : String?
    var is_gender : String?
    
    
    enum CodingKeys: String, CodingKey
    {
        case id = "id"
        case step = "step"
        case name = "name"
        case email = "email"
        case mobile = "mobile"
        case pincode_id = "pincode_id"
        case gender = "gender"
        case dob = "dob"
        case blood_group = "blood_group"
        case member_code = "member_code"
        case is_otp_verified = "is_otp_verified"
        case auth_token = "auth_token"
        case last_login_date = "last_login_date"
        case is_user_profile_image = "is_user_profile_image"
        case is_blood_group = "is_blood_group"
        case is_gender = "is_gender"
    }
    
    required init(from decoder: Decoder) throws
    {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        step = try values.decodeIfPresent(Int.self, forKey: .step)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        pincode_id = try values.decodeIfPresent(String.self, forKey: .pincode_id)
        gender = try values.decodeIfPresent(Int.self, forKey: .gender)

        dob = try values.decodeIfPresent(String.self, forKey: .dob)
        
        blood_group = try values.decodeIfPresent(Int.self, forKey: .blood_group)
        member_code = try values.decodeIfPresent(String.self, forKey: .member_code)
        is_otp_verified = try (values.decodeIfPresent(String.self, forKey: .is_otp_verified))
        auth_token = try values.decodeIfPresent(String.self, forKey: .auth_token)
        last_login_date = try values.decodeIfPresent(String.self, forKey: .last_login_date)
        is_user_profile_image = try values.decodeIfPresent(String.self, forKey: .is_user_profile_image)
        is_blood_group = try values.decodeIfPresent(String.self, forKey: .is_blood_group)
        is_gender = try values.decodeIfPresent(String.self, forKey: .is_gender)
    }
}
