//
//  CheckInfoRequest.swift
//  VTBHack
//
//  Created by Кирилл Володин on 14/09/2019.
//  Copyright © 2019 RxProject. All rights reserved.
//

import Foundation
import Alamofire

class CheckInfoRequest: RequestConfig<CheckInfoDto> {
    init(rawQRCode: String) {
        let parameters: Parameters = [:]
        let headers: HTTPHeaders = [
            "Content-Type" : "application/json"
        ]
        let parser = CheckInfoParser()
        let rawURL = "/check/info?\(rawQRCode)"
        super.init(
            url: rawURL,
            parameters: parameters,
            headers: headers,
            method: .get,
            encoding: URLEncoding.default,
            parser: parser
        )
    }
}
