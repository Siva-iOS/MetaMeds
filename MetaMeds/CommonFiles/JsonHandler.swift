//
//  JsonHandler.swift
//  BikeTaxi
//
//  Created by Kumar on 10/06/19.
//  Copyright © 2019 Kumar. All rights reserved.
//

import Foundation
import UIKit
import SystemConfiguration

var window: UIWindow?

class JsonHandler: NSObject
{
    static func jsonParsing<T:Codable>(webservice:String,params:T,headers:[String:String]?,showIt:Bool,ResponseSucess:@escaping(Data)-> Void,ResponseError:@escaping(Error) -> Void)
    {
        if Reachability.isConnectedToNetwork()
        {
            
            if showIt
            {
                DispatchQueue.main.async
                {
                        UIApplication.topViewController()?.view.activityStartAnimating(activityColor: UIColor.black, backgroundColor: UIColor.clear)
                }
            }
            
            var request = URLRequest(url:URL(string: webservice)! , cachePolicy: .useProtocolCachePolicy, timeoutInterval: 50.0)
            request.httpMethod = "POST"
            
            do
            {
                let jsonData = try JSONEncoder().encode(params)
                request.httpBody = jsonData
                request.allHTTPHeaderFields = headers
                
                let value = String(decoding: jsonData, as: UTF8.self)
                print("URL>>>>>>>>>> ",webservice)
                print("Request>>>>>>>>>> ",value)
                print("headers>>>>>>>>>> ",headers)
            }
            catch
            {
            }
            
            let  sessionConfig =  URLSessionConfiguration.default
            if #available(iOS 11.0, *)
            {
                sessionConfig.waitsForConnectivity =  true
            }
            let session = URLSession(configuration: sessionConfig)
            
            let dataTask = session.dataTask(with: request){(response,empty,error)
                in
                
                guard let responseData = response else
                {
                    ResponseError(error!)
                    DispatchQueue.main.async
                    {
                            UIApplication.topViewController()?.view.activityStopAnimating()
                    }
                    return
                }
                
                DispatchQueue.main.async
                {
                        UIApplication.topViewController()?.view.activityStopAnimating()
                }
                
                let value = String(decoding: responseData, as: UTF8.self)
                print("RESPONSE>>>>>>>>>> ",value)
                ResponseSucess(responseData)
                
            }
            dataTask.resume()
        }
        else
        {
            DispatchQueue.main.async
            {
                Toast(message: "Please check Internet Connection..!", view: UIApplication.topViewController()!.view)
            }
        }
    }
    
    
    
    static func multipartParsing(webservice:String, params:[String: AnyObject], mediaData:[String:Data],headers:[String:String]?, showIt:Bool, sucess:@escaping(Data)-> Void, failure:@escaping(String) ->Void, error:@escaping(Error) -> Void)
    {
        if Reachability.isConnectedToNetwork()
        {
            if showIt
            {
                DispatchQueue.main.async
                {
                        UIApplication.topViewController()?.view.activityStartAnimating(activityColor: UIColor.black, backgroundColor: UIColor.clear)
                }
            }
            let filename = "profile.jpg"
            
            // generate boundary string using a unique per-app string
            let boundary = UUID().uuidString
            
            let config = URLSessionConfiguration.default
            let session = URLSession(configuration: config)
            
            var urlRequest = URLRequest(url: URL(string: webservice)!)
            urlRequest.httpMethod = "POST"
            urlRequest.allHTTPHeaderFields = headers
            
            urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            
            var data = Data()
            
            for (key, value) in params
            {
                data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
                data.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
                data.append("\(value)".data(using: .utf8)!)
                
                print("key>>>>>>> ",key,"PARAM>>>>>>>>> ",value)
                
            }
            
            for (key, value) in mediaData
            {
                data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
                
                data.append("Content-Disposition: form-data; name=\"\(key)\"; filename=\"\(filename)\"".data(using: .utf8)!)
                
                if value.count > 0
                {
                    data.append("Content-Type: \(value.formatMimeType)\r\n\r\n".data(using: .utf8)!)
                }
                else
                {
                    data.append("Content-Type: \("jpg")\r\n\r\n".data(using: .utf8)!)
                }
                
                data.append(value)
                
                print("MULTIPARAM>>>>>>>>> ",value)
            }
            
            data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
            
            session.uploadTask(with: urlRequest, from: data, completionHandler: { responseData, response, error in
                
                if(error != nil)
                {
                    print("\(error!.localizedDescription)")
                }
                
                guard let responseData = responseData else {
                    print("no response data")
                    DispatchQueue.main.async
                        {
                            UIApplication.topViewController()?.view.activityStopAnimating()
                    }
                    return
                }
                
                DispatchQueue.main.async
                    {
                        UIApplication.topViewController()?.view.activityStopAnimating()
                }
                
                let value = String(decoding: responseData, as: UTF8.self)
                print("RESPONSE>>>>>>>>>> ",value)
                sucess(responseData)
                
            }).resume()
        }
        else
        {
            DispatchQueue.main.async
            {
                Toast(message: "Please check Internet Connection..!", view: UIApplication.topViewController()!.view)
            }
        }
    }
    
    static func multipartMultiImageParsing(webservice:String, params:[String: AnyObject], mediaParam:String,mediaData:[Data],headers:[String:String]?, showIt:Bool, sucess:@escaping(Data)-> Void, failure:@escaping(String) ->Void, error:@escaping(Error) -> Void)
    {
        if Reachability.isConnectedToNetwork()
        {
            if showIt
            {
                DispatchQueue.main.async
                {
                        UIApplication.topViewController()?.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.6))
                }
            }
//            let filename = "profile.jpg"
            let filename = FileName
            // generate boundary string using a unique per-app string
            let boundary = UUID().uuidString
            
            let config = URLSessionConfiguration.default
            let session = URLSession(configuration: config)
            
            var urlRequest = URLRequest(url:URL(string: webservice)! , cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60.0)
            urlRequest.httpMethod = "POST"
            urlRequest.allHTTPHeaderFields = headers
            
            urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            
            var data = Data()
            
            for (key, value) in params
            {
                data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
                data.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
                data.append("\(value)".data(using: .utf8)!)
                
                print("key>>>>>>> ",key,"value>>>>>>>>> ",value)
                
            }
            
//            for value in mediaData
//            {
                var i = 0
                while i < mediaData.count
                {
                    data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
                    data.append("Content-Disposition: form-data; name=\"\(mediaParam)\"; ".data(using: .utf8)!)

                    if mediaData[i].count > 0
                    {
                        data.append("Content-Type: \(mediaData[i].formatMimeType)\r\n\r\n".data(using: .utf8)!)
                    }
                    else
                    {
                        data.append("Content-Type: \("jpg")\r\n\r\n".data(using: .utf8)!)
                    }
                    
                    data.append(mediaData[i])
//                    print("FILENAME>>>>>>>>> ",filename[i])
                    print("MULTIPARAM>>>>>>>>> ",mediaParam)
                    print("MULTIVALUE>>>>>>>>> ",mediaData[i])
                    i += 1
                }
                
//            }
            
            
            
            data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
            
            session.uploadTask(with: urlRequest, from: data, completionHandler: { responseData, response, error in
                
                if(error != nil)
                {
                    print("\(error!.localizedDescription)")
                }
                
                guard let responseData = responseData else {
                    print("no response data")
                    DispatchQueue.main.async
                        {
                            UIApplication.topViewController()?.view.activityStopAnimating()
                    }
                    return
                }
                
                DispatchQueue.main.async
                    {
                        UIApplication.topViewController()?.view.activityStopAnimating()
                }
                
                let value = String(decoding: responseData, as: UTF8.self)
                print("RESPONSE>>>>>>>>>> ",value)
                sucess(responseData)
                
            }).resume()
        }
        else
        {
            DispatchQueue.main.async
            {
                Toast(message: "Please check Internet Connection..!", view: UIApplication.topViewController()!.view)
            }
        }
    }
    
    
}


public class Reachability {
    
    class func isConnectedToNetwork() -> Bool
    {
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        
        // Working for Cellular and WIFI
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)
        
        return ret
        
    }
    
}
