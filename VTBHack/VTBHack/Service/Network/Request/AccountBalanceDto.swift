//
//  AccountBalanceDto.swift
//  VTBHack
//
//  Created by Кирилл Володин on 14/09/2019.
//  Copyright © 2019 RxProject. All rights reserved.
//

import Foundation
import Alamofire

class AccountBalanceRequest: RequestConfig<AccountBalanceDto> {
    init(address: String) {
        let parameters: Parameters = [
            "address": address,
            "currencyCode": 810
        ]
        let headers: HTTPHeaders = [
//            "Content-Type" : "application/json",
            "FPSID": ServiceLayer.shared.accountService.sessionId
        ]
        let parser = AccountBalanceParser()
        let rawURL = "/transaction/810/balance/\(address)"
        print(rawURL)
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
