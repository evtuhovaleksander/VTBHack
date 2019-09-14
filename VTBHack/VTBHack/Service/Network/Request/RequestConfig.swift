//
//  RequestConfig.swift
//  VTBHack
//
//  Created by Кирилл Володин on 14/09/2019.
//  Copyright © 2019 RxProject. All rights reserved.
//

import Foundation
import Alamofire

class RequestConfig<Model> {
    
    var baseURL = ""
    var url: String
    var parameters: Parameters
    var headers: HTTPHeaders
    var method: HTTPMethod
    var encoding: ParameterEncoding
    var parser: Parser<Model>
    
    init(
        baseURL: String = "https://herokutestforrx.herokuapp.com",
        url: String = "",
        parameters: Parameters = [:],
        headers: HTTPHeaders = [:],
        method: HTTPMethod = .get,
        encoding: ParameterEncoding = URLEncoding(destination: .methodDependent),
        parser: Parser<Model>
    ) {
        self.baseURL = baseURL
        self.url = "\(baseURL)\(url)"
        self.parameters = parameters
        self.headers = headers
        self.method = method
        self.encoding = encoding
        self.parser = parser
        
    }
}
