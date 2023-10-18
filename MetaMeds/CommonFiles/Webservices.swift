//
//  Webservices.swift
//  BikeTaxi
//
//  Created by Kumar on 11/06/19.
//  Copyright © 2019 Kumar. All rights reserved.
//

import Foundation

struct Webservices
{
    static let BaseUrl = "http://3.12.170.234/metameds/api/"
    
    static let Login = BaseUrl + "login"
    static let VerifyOtp = BaseUrl + "verify_otp"
    static let ResendOTP = BaseUrl + "resend_otp"
    static let UpdateProfile = BaseUrl + "profile_update"
    static let BloodGroupList = BaseUrl + "get_list"
    static let HomeContent = BaseUrl + "home_content"
    static let GetPost = BaseUrl + "get_post"
    static let CreatePost = BaseUrl + "create_post"
    static let ViewPost = BaseUrl + "view_post"
    static let EditProfile = BaseUrl + "profile_edit"
    static let Logout = BaseUrl + "logout"
    static let ProfilePic = BaseUrl + "profile_image_upload"
    static let Notification = BaseUrl + "get_notificationlist"
    static let GuestLogin = BaseUrl + "guest_login"
    static let Rating = BaseUrl + "is_receive"
}
