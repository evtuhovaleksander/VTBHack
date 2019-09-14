//
//  GroupDatasource.swift
//  VTBHack
//
//  Created by Кирилл Володин on 14/09/2019.
//  Copyright © 2019 RxProject. All rights reserved.
//

import Foundation

class GroupDatasource {
    let model: [Group] = [
        Group(amount: 6600, title: "Пятничная туса", date: "13.09.2019", isCompleted: false),
        Group(amount: 8975, title: "Встреча с одногруппниками", date: "07.09.2019", isCompleted: true),
        Group(amount: 100, title: "Поход в ресторан", date: "10.08.2019", isCompleted: true),
        Group(amount: 100, title: "Пикник", date: "25.07.2019", isCompleted: true)
    ]
    
    var activeGroups: [Group] {
        return model.filter { !$0.isCompleted }
    }
    
    var completedGroups: [Group] {
        return model.filter { $0.isCompleted }
    }
}
