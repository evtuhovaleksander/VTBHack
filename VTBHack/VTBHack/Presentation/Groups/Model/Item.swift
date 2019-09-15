//
//  Item.swift
//  VTBHack
//
//  Created by Кирилл Володин on 15/09/2019.
//  Copyright © 2019 RxProject. All rights reserved.
//

import Foundation

class Item {
    var price: Int
    var title: String
    var selectedPersonId: Int?
    
    init(price: Int, title: String) {
        self.price = price
        self.title = title
    }
}
