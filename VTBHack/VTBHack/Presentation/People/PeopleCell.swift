//
//  PeopleCell.swift
//  VTBHack
//
//  Created by Aleksander Evtuhov on 14/09/2019.
//  Copyright © 2019 RxProject. All rights reserved.
//

import UIKit

class PeopleCell: UITableViewCell {
    
    @IBOutlet var containerView: UIView!
    @IBOutlet var avatarContainerView: UIView!
    
    @IBOutlet var nickLabel: UILabel!
    
    @IBOutlet var phoneLabel: UILabel!
    
    @IBOutlet var selectedImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 10.0
        containerView.clipsToBounds = true
        avatarContainerView.layer.cornerRadius = 25.0
        avatarContainerView.clipsToBounds = true
        avatarContainerView.backgroundColor = UIColor.Color.blueButtonBorder
        containerView.backgroundColor = .white
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    func configure(model: Contact) {
        nickLabel.text = model.nickName
        phoneLabel.text = model.phone
        selectedImageView.image = model.selected
        ? UIImage(named: "check1")
        : nil
    }
    
    
}
