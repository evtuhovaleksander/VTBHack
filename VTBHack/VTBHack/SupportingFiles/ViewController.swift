//
//  ViewController.swift
//  VTBHack
//
//  Created by Aleksander Evtuhov on 14/09/2019.
//  Copyright © 2019 RxProject. All rights reserved.
//

import UIKit

struct Card {
    var color: UIColor
    var name: String
    
    static func getData() -> [Card] {
        return [
            Card(color: .blue, name: "bitmap2"),
            Card(color: .green, name: "bitmap1"),
            Card(color: UIColor.yellow.withAlphaComponent(0.9), name: "bitmap1")
        ]
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var moneyAmount: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var secondStackView: UIStackView!
    
    private let cellId = "cardCell"
    
    private var cards = Card.getData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBalance()
        setupCards()
        setupSecondStack()
        view.backgroundColor = UIColor(hex: "f8f8f8")
        
        // collectionView setup
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "CardCell", bundle: nil), forCellWithReuseIdentifier: cellId)
        collectionView.reloadData()
        collectionView.backgroundColor = UIColor(hex: "f8f8f8")
    }
    
    func setupBalance() {
        let amount = ServiceLayer.shared.infoService.accountInfo?.data.total ?? 0
        moneyAmount.text = "\(amount), 00 ₽"
    }
    
    func setupCards() {
        let firstCard: MainView = MainView.loadFromNib()
        firstCard.cardImage.image = UIImage(named: "group2")
        firstCard.cardName.text = "Счет ВТБ"
        firstCard.moneyAmount.text = "31 600, 00 ₽"
        stackView.addArrangedSubview(firstCard)
        
        let secondCard: MainView = MainView.loadFromNib()
        secondCard.cardImage.image = UIImage(named: "group")
        secondCard.cardName.text = "Счет Tinkoff Black"
        secondCard.moneyAmount.text = "6 100, 00 ₽"
        secondCard.separator.isHidden = true
        stackView.addArrangedSubview(secondCard)
    }
    
    func setupSecondStack() {
        let first: SugestsView = SugestsView.loadFromNib()
        first.mainView.layer.cornerRadius = 9
        first.mainView.clipsToBounds = true
        first.backgroundColor = UIColor(hex: "f8f8f8")
        first.leftImageView.image = UIImage(named: "lenta")
        first.rightImage.image = UIImage(named: "check1")
        first.topLabel.text = "Cеть магазинов Лента"
        first.bottomLabel.text = "7% на все покупки"
        secondStackView.addArrangedSubview(first)
        
        let second: SugestsView = SugestsView.loadFromNib()
        second.mainView.layer.cornerRadius = 9
        second.mainView.clipsToBounds = true
        second.backgroundColor = UIColor(hex: "f8f8f8")
        second.leftImageView.image = UIImage(named: "karusel")
        second.rightImage.image = UIImage(named: "check2")
        second.topLabel.text = "Cеть магазинов Карусель"
        second.bottomLabel.text = "10% на первую покупку"
        secondStackView.addArrangedSubview(second)
        
        let third: SugestsView = SugestsView.loadFromNib()
        third.mainView.layer.cornerRadius = 9
        third.mainView.clipsToBounds = true
        third.backgroundColor = UIColor(hex: "f8f8f8")
        third.leftImageView.image = UIImage(named: "goods")
        third.rightImage.image = UIImage(named: "check2")
        third.topLabel.text = "Goods.ru"
        third.bottomLabel.text = "13% на первую покупку"
        secondStackView.addArrangedSubview(third)
    }

}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cardCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CardCell
        cardCell.configure(image: UIImage(named: cards[indexPath.row].name)!)
        return cardCell
    }
}

extension ViewController: UICollectionViewDelegate {
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let center = CGPoint(x: scrollView.contentOffset.x + (scrollView.frame.width / 2),
//                             y: (scrollView.frame.height / 2))
//        if let ip = collectionView.indexPathForItem(at: center) {
//            pageControl.currentPage = ip.row
//        }
//    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width / 2.25, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: -8, bottom: 0, right: -8)
    }
}

