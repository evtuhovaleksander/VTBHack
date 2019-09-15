//
//  ItemsDataSource.swift
//  VTBHack
//
//  Created by Кирилл Володин on 15/09/2019.
//  Copyright © 2019 RxProject. All rights reserved.
//

import Foundation

class ItemsDataSource {
    var items = [Item]()
    var checkItemsDto: CheckInfoDto? = nil
    
    func updateData() {
        guard let checkItemsDto = checkItemsDto else { return }
        checkItemsDto.items.forEach {
            let item = Item(price: $0.price, title: $0.name)
            items.append(item)
        }
    }
    
    init() {
        items = [
            Item(price: 1, title: "1"),
            Item(price: 2, title: "2"),
            Item(price: 3, title: "3"),
            Item(price: 4, title: "4")
        ]
    }
}
