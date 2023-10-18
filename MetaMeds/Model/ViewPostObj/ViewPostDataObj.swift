//
//  ViewPostDataObj.swift
//  MetaMeds
//
//  Created by Ajeeth Kumar on 06/10/23.
//

import UIKit

class ViewPostDataObj: Codable
{
    var id : Int?
    var user_id : Int?
    var patient_name : String?
    var attendee_name : String?
    var mobile : String?
    var dob : String?
    var blood_group : Int?
    var request_id : Int?
    var quantity : Int?
    var location_id : Int?
    var latitude : Double?
    var longitude : Double?
    var address : String?
    var request_date : String?
    var is_critical : Int?
    var accept_terms : Int?
    var image : String?
    var age : Int?
    var is_blood_group : String?
}
