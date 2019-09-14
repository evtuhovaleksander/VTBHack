//
//  GroupCell.swift
//  VTBHack
//
//  Created by Кирилл Володин on 14/09/2019.
//  Copyright © 2019 RxProject. All rights reserved.
//

import UIKit

class GroupCell: UITableViewCell {

    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        separatorInset = .zero
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func fill(amount: String = "6600", title: String, date: String) {
        let attributedString = NSMutableAttributedString(string: "\(amount) ₽", attributes: [
            .font: UIFont.systemFont(ofSize: 15.0, weight: .bold),
            .foregroundColor: UIColor(red: 0.0, green: 62.0 / 255.0, blue: 195.0 / 255.0, alpha: 1.0),
            .kern: 0.03
            ])
        amountLabel.attributedText = attributedString
        
        titleLabel.text = title
        dateLabel.text = date
    }
    
}
