//
//  UploadUpdateProfileObj.swift
//  GFA Ecommerce
//
//  Created by Smarthermacmini1 on 04/06/21.
//  Copyright © 2021 Smarthermacmini. All rights reserved.
//

import UIKit

struct UploadUpdateProfileObj: Codable
{
    var user_id : Int?
    var name : String?
    var email : String?
    var pincode_id : String?
    var gender : Int?
    var dob : String?
    var blood_group : Int?
    var mobile : String?
}
