//
//  Account.swift
//  VTBHack
//
//  Created by Кирилл Володин on 14/09/2019.
//  Copyright © 2019 RxProject. All rights reserved.
//

import Foundation

class AccountBalanceDto: Decodable {
    let data: AccountBalanceDataDto
}

class AccountBalanceDataDto: Decodable {
    let currencyCode: Int
    let address: String
    let total: Int
}
