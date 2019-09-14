//
//  Group.swift
//  VTBHack
//
//  Created by Кирилл Володин on 14/09/2019.
//  Copyright © 2019 RxProject. All rights reserved.
//

import Foundation

class Group {
    
    var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM.dd.yyyy"
        return formatter
    }()
    
    var amount: Int = 6600
    var title: String = ""
    var date: String = ""
    
    var isCompleted: Bool
    
    init(amount: Int, title: String, date: Date, isCompleted: Bool) {
        self.amount = amount
        self.title = title
        self.date = formatter.string(from: date)
        self.isCompleted = isCompleted
    }
    
    init(amount: Int, title: String, date: String, isCompleted: Bool) {
        self.amount = amount
        self.title = title
        self.date = date
        self.isCompleted = isCompleted
    }
}
