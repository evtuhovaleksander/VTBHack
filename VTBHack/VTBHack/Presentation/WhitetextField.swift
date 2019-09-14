//
//  WhitetextField.swift
//  VTBHack
//
//  Created by Aleksander Evtuhov on 14/09/2019.
//  Copyright © 2019 RxProject. All rights reserved.
//

import UIKit

class WhitetextField: UITextField {
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 1.0
    }
}
