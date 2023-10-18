//
//  UserResponseObj.swift
//  GFA Ecommerce
//
//  Created by Smarthermacmini on 31/07/20.
//  Copyright © 2020 Smarthermacmini. All rights reserved.
//

import UIKit

class UserResponseObj: Codable
{
    var status : Int?
    var data : UserDataObj?
    var walletamount : Int?
    var message : String?
    
    init()
    {
        
    }
    
    enum CodingKeys: String, CodingKey
    {
        case status = "status"
        case data = "data"
        case walletamount = "walletamount"
        case message = "message"
    }
    
    required init(from decoder: Decoder) throws
    {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        data = try values.decodeIfPresent(UserDataObj.self, forKey: .data)
        walletamount = try values.decodeIfPresent(Int.self, forKey: .walletamount)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }
}

class ResponseObj: Codable
{
    var status : Int?
    var message : String?
}
