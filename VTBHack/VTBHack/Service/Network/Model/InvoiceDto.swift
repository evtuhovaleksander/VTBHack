//
//  InvoiceDto.swift
//  VTBHack
//
//  Created by Кирилл Володин on 14/09/2019.
//  Copyright © 2019 RxProject. All rights reserved.
//

import Foundation

class InvoiceDto: Decodable {
    let data: TransactionDto
}

class TransactionDto: Decodable {
    let txId: String
}
