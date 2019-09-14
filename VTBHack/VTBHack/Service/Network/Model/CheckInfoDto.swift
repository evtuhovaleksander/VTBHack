//
//  CheckInfoDto.swift
//  VTBHack
//
//  Created by Кирилл Володин on 14/09/2019.
//  Copyright © 2019 RxProject. All rights reserved.
//

import Foundation

struct CheckInfoDto: Decodable {
    let items: [CheckItemDto]
}

struct CheckItemDto: Decodable {
    let name: String
    let price: Int
    let quantity: Int
    let sum: Int
}
