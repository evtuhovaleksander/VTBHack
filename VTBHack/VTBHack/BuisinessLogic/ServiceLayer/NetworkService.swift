//
//  NetworkService.swift
//  VTBHack
//
//  Created by Aleksander Evtuhov on 14/09/2019.
//  Copyright © 2019 RxProject. All rights reserved.
//

import Foundation
//import Alamofire
//
//class NetworkService {
//    func getEvent(//prog data model
//        completion: VoidBlock,
//        failure: ErrorBlock
//        ) {//prog data model
//        let url = URL(string: "")!
//        request(
//            URL: url,
//            method: .get,
//            parameters: request.parameters,
//            onSuccess: onSuccess,
//            onError: failure
//        )
//    }
//    
//    
//    //get Request
//    private static func request(
//        URL: String,
//        method: HTTPMethod,
//        parameters: Parameters,
//        onSuccess: @escaping (Data) -> Void,
//        onError: @escaping (Any) -> Void,
//        encoding: ParameterEncoding = URLEncoding.default
//    ) -> Void {
//        
//        var headers: HTTPHeaders? = [:]
//        if let token = ASWDatabaseManager().getUser()?.access_token {
//            headers = ["x-access-token":token,"Content-Type":"application/json"]
//        }
//        
//        Alamofire.request(URL, method: method, parameters: parameters, encoding: encoding, headers: headers).validate().responseJSON { response in
//            switch response.result {
//            case .success(let value):
//                let json = JSON(value)
//                DispatchQueue.global(qos: .userInitiated).async {
//                    onSuccess(json)
//                }
//            case .failure(let error):
//                DispatchQueue.global(qos: .userInitiated).async {
//                    let json = JSON(error)
//                    print(error)
//                    onError(error)
//                }
//            }
//        }
//    }
//    
//    
//    private static func secretRequest(URL: String, method: HTTPMethod, parameters: Parameters, encoding: ParameterEncoding, onSuccess: @escaping (JSON) -> Void , onError: @escaping (JSON,Error) -> Void, acessToken:String) -> Void {
//        print("requesting URL \(URL)")
//        
//        let headers = ["x-access-token":acessToken, "Content-Type":"application/json"]
//        
//        Alamofire.request(URL, method: method, parameters: parameters,encoding: encoding, headers: headers ).validate().responseJSON { response in
//            switch response.result {
//            case .success(let value):
//                DispatchQueue.global(qos: .userInitiated).async {
//                    let json = JSON(value)
//                    onSuccess(json)
//                }
//            case .failure(let error):
//                DispatchQueue.global(qos: .userInitiated).async {
//                    var json = JSON()
//                    if let data = response.data {
//                        do {
//                            json = try JSON(data: data)
//                        }
//                        catch {
//                            return
//                        }
//                    }
//                    DispatchQueue.main.async {
//                        onError(json,error)
//                    }
//                }
//            }
//        }
//    }
//    
//    private static func authRequest(URL: String, method: HTTPMethod, parameters: Parameters, onSuccess: @escaping (JSON) -> Void , onError: @escaping (JSON,NSError) -> Void) -> Void {
//        
//        Alamofire.request(URL, method: method, parameters: parameters ).validate().responseJSON { response in
//            switch response.result {
//            case .success(let value):
//                let json = JSON(value)
//                DispatchQueue.main.async {
//                    onSuccess(json)
//                }
//            case .failure(let error):
//                DispatchQueue.global(qos: .userInitiated).async {
//                    print(error)
//                    var json = JSON()
//                    if let data = response.data {
//                        do {
//                            var str = String(data: data, encoding: String.Encoding.utf8) as String? ?? ""
//                            print(str)
//                            str = str.replacingOccurrences(of: "\"code\":null", with: "\"code\":0")
//                            print(str)
//                            var newData = str.data(using: String.Encoding.utf8) ?? data
//                            json = try JSON(data: newData)
//                        }
//                        catch{
//                            print(error)
//                        }
//                    }
//                    DispatchQueue.main.async {
//                        onError(json, error as NSError)
//                    }
//                }
//            }
//        }
//    }
//    
//    class func defaultOnSuccess(json: JSON) -> Void{
//        print(json)
//    }
//    
//    class func defaultOnError(error: Any) -> Void {
//        print(error)
//    }
//    
//}
//
//enum Result<T> {
//    case success(T)
//    case error(String)
//}
