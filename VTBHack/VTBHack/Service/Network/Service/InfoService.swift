//
//  InfoService.swift
//  VTBHack
//
//  Created by Aleksander Evtuhov on 14/09/2019.
//  Copyright © 2019 RxProject. All rights reserved.
//

import Foundation

class InfoService {
    var accountAdress: String?
    var accountInfo: AccountBalanceDto?
    var identifier: String?
    var nick: String {
        guard let identifier = identifier else { return "Настя" }
        switch identifier {
        case "79999999999":
            return "Никита"
        case "79999999998":
            return "Кирилл"
        default:
            return "Настя"
        }
    }
}
