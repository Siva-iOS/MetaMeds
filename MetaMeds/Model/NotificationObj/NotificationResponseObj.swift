//
//  NotificationResponseObj.swift
//  MetaMeds
//
//  Created by Ajeeth Kumar on 09/10/23.
//

import UIKit

class NotificationResponseObj: Codable
{
    var status : Int?
    var data : [NotificationDataObj]?
    var message : String?
}
