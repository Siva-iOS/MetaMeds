//
//  UploadHeaderObj.swift
//  Fag
//
//  Created by Smarthermacmini on 02/11/20.
//  Copyright © 2020 Gowtham. All rights reserved.
//

import UIKit

struct UploadHeaderObj
{
    var Authorization : String?
    
    var dictionaryRepresentation: [String: String] {
        return [
            "Authorization" : Authorization!,
        ]
    }
}
