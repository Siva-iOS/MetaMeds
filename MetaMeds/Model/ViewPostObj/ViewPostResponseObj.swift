//
//  ViewPostResponseObj.swift
//  MetaMeds
//
//  Created by Ajeeth Kumar on 06/10/23.
//

import UIKit

class ViewPostResponseObj: Codable
{
    var status : Int?
    var data : [PostDataObj]?
    var message : String?
}
