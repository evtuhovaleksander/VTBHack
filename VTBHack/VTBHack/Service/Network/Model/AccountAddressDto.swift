//
//  AccountAddressDto.swift
//  VTBHack
//
//  Created by Кирилл Володин on 14/09/2019.
//  Copyright © 2019 RxProject. All rights reserved.
//

import Foundation

class AccountAddressDto: Decodable {
    let data: AccountAddressDataDto
}

class AccountAddressDataDto: Decodable {
    let address: String
//    "currencyCode": 810,
//    "state": 1,
//    "juridicalType": 0,
//    "bikBankSetterJuridicalType": "044525225",
//    "identityType": 1,
//    "owner": "263093b1c21f98c5f9b6433bf9bbb97bb87b6e79",
//    "identifiers": [
//    "8c210472bec8a987faf06c13b003f33e926e370b28bcbc00835c4179d7034e23"
//    ],
//    "encrypted": false
//    }
}
