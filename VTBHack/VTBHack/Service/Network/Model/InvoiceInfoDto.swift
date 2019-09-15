//
//  InvoiceInfoDto.swift
//  VTBHack
//
//  Created by Кирилл Володин on 14/09/2019.
//  Copyright © 2019 RxProject. All rights reserved.
//

import Foundation

class InvoiceInfoDto: Decodable {
    let data: InvoiceInfoDataDto
}

class InvoiceInfoDataDto: Decodable {
    let number: String
    let amount: Int
    let description: String
    let recipient: String
    let payer: String
    let state: InvoiceState
    /// тут скорее всего таймстемп приходит
    let created: Int
    /// тут скорее всего таймстемп приходит
    let updated: Int
    let owner: String
//    "errorCode": 0
}

enum InvoiceState: Int, Decodable {
    /// 0 – Не определен
    case undefined
    /// 1 - Создан
    case created
    /// 2 – Выставлен
    case open
    /// 3 – Ошибочный счет
    case wrong
    /// 4 – Истекло время действия счета
    case timeout
    /// 5 - Оплачен
    case closed
    
    var stateDescription: String {
        switch self {
        case .undefined:
            return "Не определен"
        case .created:
            return "Создан"
        case .open:
            return "Выставлен"
        case .wrong:
            return "Ошибочный счет"
        case .timeout:
            return "Истекло время действия счета"
        case .closed:
            return "Оплачен"
        }
    }
}
