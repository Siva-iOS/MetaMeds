//
//  UploadLoginObj.swift
//  GFA Ecommerce
//
//  Created by Smarthermacmini on 31/07/20.
//  Copyright © 2020 Smarthermacmini. All rights reserved.
//

import UIKit

struct UploadLoginObj: Codable
{
    var user_id : Int?
    var first_name : String?
    var email : String?
    var mobile : String?
    var fcm_token : String?
    var device_type : String?
    var device_id : String?
    var country_code : String?
}
