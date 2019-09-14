//
//  MainView.swift
//  VTBHack
//
//  Created by Roman Nordshtrem on 14/09/2019.
//  Copyright © 2019 RxProject. All rights reserved.
//

import UIKit

class MainView: UIView {

    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var cardName: UILabel!
    @IBOutlet weak var moneyAmount: UILabel!
    @IBOutlet weak var separator: UIView!
    
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        commonInit()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        commonInit()
//    }
//
//    private func commonInit() {
//        Bundle.main.loadNibNamed("CardView", owner: self, options: nil)
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    class func instantiate() -> MainView {
        let myClassNib = UINib(nibName: "CardView", bundle: nil)
        return myClassNib.instantiate(withOwner: nil, options: nil)[0] as! MainView
    }

}

