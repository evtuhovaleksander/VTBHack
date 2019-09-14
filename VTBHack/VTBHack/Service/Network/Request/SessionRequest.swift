//
//  SessionRequest.swift
//  VTBHack
//
//  Created by Кирилл Володин on 14/09/2019.
//  Copyright © 2019 RxProject. All rights reserved.
//

import Foundation
import Alamofire

class SessionRequest: RequestConfig<SessionDto> {
    init() {
        
        //{
        //    "addresses": [
        //    "string"
        //    ],
        //    "deviceId": "string",
        //    "deviceType": 0
        //}

        let parameters: Parameters = [
            "addresses": [],
            "deviceId": "rxproject_device_id",
            "deviceType": 2
        ]
        let headers: HTTPHeaders = [
            "Content-Type" : "application/json"
        ]
        let parser = SessionParser()
        super.init(
            baseURL: "http://89.208.84.235:31080/api/v1",
            url: "/session",
            parameters: parameters,
            headers: headers,
            method: .post,
            encoding: JSONEncoding.default,
            parser: parser
        )
    }
}
