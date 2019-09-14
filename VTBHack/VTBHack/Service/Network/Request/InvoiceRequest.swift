//
//  InvoiceRequest.swift
//  VTBHack
//
//  Created by Кирилл Володин on 14/09/2019.
//  Copyright © 2019 RxProject. All rights reserved.
//

import Foundation
import Alamofire

class InvoiceRequest: RequestConfig<InvoiceDto> {
    init(
        amount: Int,
        currencyCode: Int = 810,
        description: String = "Счет за общий чек",
        number: String = ServiceLayer.shared.accountService.sessionId,
        payer: String,
        recipient: String
    ) {
        let parameters: Parameters = [
            "amount": amount,
            "currencyCode": 810,
            "description": description,
            "number": number,
            "payer": payer,
            "recipient": recipient
        ]
        let headers: HTTPHeaders = [
            "Content-Type" : "application/json",
            "FPSID": ServiceLayer.shared.accountService.sessionId
        ]
        let parser = InvoiceParser()
        let rawURL = "/invoice"
        super.init(
            url: rawURL,
            parameters: parameters,
            headers: headers,
            method: .post,
            encoding: JSONEncoding.default,
            parser: parser
        )
    }
}
