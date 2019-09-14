//
//  CardCell.swift
//  VTBHack
//
//  Created by Roman Nordshtrem on 14/09/2019.
//  Copyright © 2019 RxProject. All rights reserved.
//

import UIKit

class CardCell: UICollectionViewCell {
    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.layer.cornerRadius = 9.0
        mainView.clipsToBounds = true
    }
    
    func configure(card: Card) {
        nameLabel.text = card.a
        numberLabel.text = card.b
        mainView.backgroundColor = card.c
    }

}
