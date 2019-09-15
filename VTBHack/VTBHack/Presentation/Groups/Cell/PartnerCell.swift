//
//  PartnerCell.swift
//  VTBHack
//
//  Created by Кирилл Володин on 15/09/2019.
//  Copyright © 2019 RxProject. All rights reserved.
//

import UIKit

protocol PartnerCellDelegate: class {
    func generateQRCodeTapped(cellId: Int)
}

class PartnerCell: UITableViewCell {

    @IBOutlet weak var identifierLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var invoiceInfo: UIView!
    @IBOutlet weak var qrcodeButton: UIButton!
    
    weak var delegate: PartnerCellDelegate?
    var cellId: Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        qrcodeButton.layer.cornerRadius = 6
        qrcodeButton.clipsToBounds = true
    }
    
    @IBAction func generateQRCodeTapped(_ sender: Any) {
        delegate?.generateQRCodeTapped(cellId: cellId)
    }
    
    func fill(partner: Partner) {
        invoiceInfo.isHidden = true
        identifierLabel.text = partner.id
    }
    
    func fill(partner: Partner, invoice: InvoiceInfoDto) {
        invoiceInfo.isHidden = false
        identifierLabel.text = partner.id
        amountLabel.text = "\(invoice.data.amount) Р"
        statusLabel.text = invoice.data.state.stateDescription
    }
}
