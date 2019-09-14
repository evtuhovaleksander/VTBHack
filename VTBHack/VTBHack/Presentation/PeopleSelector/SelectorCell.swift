//
//  SelectorView.swift
//  VTBHack
//
//  Created by Aleksander Evtuhov on 15/09/2019.
//  Copyright © 2019 RxProject. All rights reserved.
//

import UIKit

class SelectorCell: UIView {
    
    @IBOutlet var containerView: UIView!
    @IBOutlet var avatarContainerView: UIView!
    
    @IBOutlet var nickLabel: UILabel!
    
    @IBOutlet var phoneLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 10.0
        containerView.clipsToBounds = true
        avatarContainerView.layer.cornerRadius = 25.0
        avatarContainerView.clipsToBounds = true
        avatarContainerView.backgroundColor = UIColor.Color.blueButtonBorder
        containerView.backgroundColor = .white
        backgroundColor = .clear
    }
    
}
