//
//  ViewController.swift
//  VTBHack
//
//  Created by Aleksander Evtuhov on 14/09/2019.
//  Copyright © 2019 RxProject. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var moneyAmount: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCards()
        
    }

    func setupCards() {
        let firstCard: MainView = MainView.loadFromNib()
        firstCard.cardImage.image = UIImage(named: "card")
        firstCard.cardName.text = "Счет ВТБ"
        firstCard.moneyAmount.text = "31 600, 00 ₽"
        stackView.addArrangedSubview(firstCard)
        let secondCard: MainView = MainView.loadFromNib()
        secondCard.cardImage.image = UIImage(named: "card")
        secondCard.cardName.text = "Счет Tinkoff Black"
        secondCard.moneyAmount.text = "6 100, 00 ₽"
        stackView.addArrangedSubview(secondCard)
    }

}

