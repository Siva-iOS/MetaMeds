//
//  Session.swift
//  SmartSuperMarket
//
//  Created by Bala Mac on 10/08/18.
//  Copyright © 2018 Smarther. All rights reserved.
//

import Foundation

struct Defaults
{
    static func SETUSERMODEL(USERM: String)
    {
        UserDefaults.standard.set(USERM, forKey: "UserProfile")
    }
    
    static func GETUSERMODEL() -> String?
    {
        return UserDefaults.standard.string(forKey: "UserProfile")
    }
    
    static func SETAddress(Address: String)
    {
        UserDefaults.standard.set(Address, forKey: "Address")
    }
    
    static func GETAddress() -> String?
    {
        return UserDefaults.standard.string(forKey: "Address")
    }
    
    static func SETAddressID(AddressID: Int)
    {
        UserDefaults.standard.set(AddressID, forKey: "AddressID")
    }
    
    static func GETAddressID() -> Int?
    {
        return UserDefaults.standard.integer(forKey: "AddressID")
    }
    
    static func SETFavouriteCount(FavCount: Int)
    {
        UserDefaults.standard.set(FavCount, forKey: "FavouriteCount")
    }
    
    static func GETFavouriteCount() -> Int?
    {
        return UserDefaults.standard.integer(forKey: "FavouriteCount")
    }
    
    static func SETCategoryID(CategoryID: Int)
    {
        UserDefaults.standard.set(CategoryID, forKey: "CategoryID")
    }
    
    static func GETCategoryID() -> Int?
    {
        return UserDefaults.standard.integer(forKey: "CategoryID")
    }
    
    static func SETPincode(Pincode: String)
    {
        UserDefaults.standard.set(Pincode, forKey: "Pincode")
    }
    
    static func GETPincode() -> String?
    {
        return UserDefaults.standard.string(forKey: "Pincode")
    }
    
    static func SETApartment(Apartment: String)
    {
        UserDefaults.standard.set(Apartment, forKey: "Apartment")
    }
    
    static func GETApartment() -> String?
    {
        return UserDefaults.standard.string(forKey: "Apartment")
    }
    
    static func SETCurrentTime(CurrentTime: String)
    {
        UserDefaults.standard.set(CurrentTime, forKey: "CurrentTime")
    }
    
    static func GETCurrentTime() -> String?
    {
        return UserDefaults.standard.string(forKey: "CurrentTime")
    }
    
    static func SET_GSTime(GSTime: Int)
    {
        UserDefaults.standard.set(GSTime, forKey: "GSTime")
    }
    
    static func GET_GSTime() -> Int?
    {
        return UserDefaults.standard.integer(forKey: "GSTime")
    }
    
    static func SET_BG(BG: Int)
    {
        UserDefaults.standard.set(BG, forKey: "BG")
    }
    
    static func GET_BG() -> Int?
    {
        return UserDefaults.standard.integer(forKey: "BG")
    }
    
    static func SET_KM(KM: Int)
    {
        UserDefaults.standard.set(KM, forKey: "KM")
    }
    
    static func GET_KM() -> Int?
    {
        return UserDefaults.standard.integer(forKey: "KM")
    }
}
struct UserObject
{
    func SaveUserObject(Obj:Data)
    {
        Defaults.SETUSERMODEL(USERM: "1")
        let value = String(decoding: Obj, as: UTF8.self)
        KeychainService.SaveUserProfile(service: ServiceKey, account: AccountKey, data: value)
    }

    func RetriveObject() -> UserResponseObj
    {
        let userToken:String = KeychainService.GetUserProfile(service: ServiceKey, account: AccountKey)!

        do
        {
            let data = Data(userToken.utf8)
            let jsonValues = try JSONDecoder().decode(UserResponseObj.self, from: data)
            return jsonValues
        }
        catch
        {

        }
        return UserResponseObj()
    }


}

