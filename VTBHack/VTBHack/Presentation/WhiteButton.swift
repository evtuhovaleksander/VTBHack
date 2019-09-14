//
//  WhiteButton.swift
//  VTBHack
//
//  Created by Aleksander Evtuhov on 14/09/2019.
//  Copyright © 2019 RxProject. All rights reserved.
//

import UIKit

class WhiteButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        clipsToBounds = true
        layer.cornerRadius = 8.0
        titleLabel?.font = .systemFont(ofSize: 19, weight: .bold)
        titleLabel?.textColor = .white
        tintColor = .white
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 1.0
    }
}
