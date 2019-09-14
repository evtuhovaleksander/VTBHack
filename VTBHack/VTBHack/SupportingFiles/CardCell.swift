//
//  CardCell.swift
//  VTBHack
//
//  Created by Roman Nordshtrem on 14/09/2019.
//  Copyright © 2019 RxProject. All rights reserved.
//

import UIKit

class CardCell: UICollectionViewCell {

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        view.layer.cornerRadius = 9.0
        view.clipsToBounds = true
    }
    
    func configure(color: UIColor, name: String) {
        view.backgroundColor = color
        nameLabel.text = name
    }

}
