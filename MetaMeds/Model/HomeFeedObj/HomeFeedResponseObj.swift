//
//  HomeFeedResponseObj.swift
//  MetaMeds
//
//  Created by Ajeeth Kumar on 06/10/23.
//

import UIKit

class HomeFeedResponseObj: Codable
{
    var status : Int?
    var data : HomeFeedDataObj?
    var message : String?
}
