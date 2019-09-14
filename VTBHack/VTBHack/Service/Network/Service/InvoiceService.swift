//
//  InvoiceService.swift
//  VTBHack
//
//  Created by Кирилл Володин on 14/09/2019.
//  Copyright © 2019 RxProject. All rights reserved.
//

import Foundation

class InvoiceService {
    private let requestSender: RequestSender
    
    init(requestSender: RequestSender) {
        self.requestSender = requestSender
    }
    
    // Входные данные
//    {
//    "amount": 1500,
//    "currencyCode": 810,
//    "description": "test description",
//    "number": "344fcb54-c81a-4ec6-a306-fc8dbd2d6167953cd861 ",
//    "payer": "da846cf70ede503fd087ede7dcbf4b9f876b80c9",
//    "recipient": "3c63a8ea371fa1c582cb6f158f8c8be7cf17cba5"
//    }
    
//    {
//    "amount": 1,
//    "currencyCode": 810,
//    "description": "счет за товар",
//    "number": "31dbb9d9-8959-48ce-9f71-b0011b911315",
//    "recipient": "2d373893b0e78939f9cb57b1243bf0b6e1375d97",
//    "payer": "4cdf2e56b045b7a526a2130213a3bf678bbf551f"
//    }
    
    func sendInvoice(
        amount: Int,
        currencyCode: Int = 810,
        description: String = "Счет за общий чек",
        number: String,
        payer: String,
        recipient: String,
        completion: ((Result<InvoiceDto>) -> Void)?
    ) {
        let request = InvoiceRequest(amount: amount, payer: payer, recipient: recipient)
        requestSender.request(config: request) { (result) in
            DispatchQueue.main.async {
                completion?(result)
            }
        }
    }
    
    func obtainInvoiceInfo(number: String, recipient: String, completion: ((Result<InvoiceInfoDto>) -> Void)?) {
        let request = InvoiceInfoRequest(number: number, recipient: recipient)
        requestSender.request(config: request) { result in
            DispatchQueue.main.async {
                completion?(result)
            }
        }
    }
}
