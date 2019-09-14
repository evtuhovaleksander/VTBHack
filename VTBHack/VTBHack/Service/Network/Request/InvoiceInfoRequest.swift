//
//  InvoiceInfoRequest.swift
//  VTBHack
//
//  Created by Кирилл Володин on 14/09/2019.
//  Copyright © 2019 RxProject. All rights reserved.
//

import Foundation
import Alamofire

class InvoiceInfoRequest: RequestConfig<InvoiceInfoDto> {
    init(number: String, recipient: String) {
        let headers: HTTPHeaders = [
            "Content-Type" : "application/json",
            "FPSID": ServiceLayer.shared.accountService.sessionId
        ]
        let parser = InvoiceInfoParser()
        let rawURL = "/invoice/810/\(number)/\(recipient)"
        print(rawURL)
        super.init(
            url: rawURL,
            parameters: [:],
            headers: headers,
            method: .get,
            encoding: URLEncoding.default,
            parser: parser
        )
    }
}
