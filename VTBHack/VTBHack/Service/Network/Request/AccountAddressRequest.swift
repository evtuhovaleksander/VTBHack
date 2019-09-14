//
//  AccountAddressRequest.swift
//  VTBHack
//
//  Created by Кирилл Володин on 14/09/2019.
//  Copyright © 2019 RxProject. All rights reserved.
//

import Foundation
import Alamofire

class AccountAddressRequest: RequestConfig<AccountAddressDto> {
    init(identifier: String) {
        let headers: HTTPHeaders = [
            "Content-Type" : "application/json",
            "FPSID": ServiceLayer.shared.accountService.sessionId
        ]
        let parser = AccountAddressParser()
        let rawURL = "/account/identifier/\(identifier)"
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
