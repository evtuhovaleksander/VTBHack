//
//  ItemCell.swift
//  VTBHack
//
//  Created by Кирилл Володин on 15/09/2019.
//  Copyright © 2019 RxProject. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet var selectedByLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func fill(item: Item, people: [Contact]) {
        titleLabel.text = item.title
        let attributedString = NSMutableAttributedString(string: "\(item.price) ₽", attributes: [
            .font: UIFont.systemFont(ofSize: 15.0, weight: .bold),
            .foregroundColor: UIColor(red: 0.0, green: 62.0 / 255.0, blue: 195.0 / 255.0, alpha: 1.0),
            .kern: 0.03
            ])
        priceLabel.attributedText = attributedString
        if let selectedId = item.selectedPersonId,
            selectedId >= 0{
            selectedByLabel.text = "Выбрана \(people[selectedId].phone)"
            selectedByLabel.textColor = UIColor.Color.statusGreen
        } else {
            selectedByLabel.text = "Ожидает выбора"
            selectedByLabel.textColor = .red
        }
        
    }
    
}
