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
            Card(color: .blue, name: "ВТБ"),
            Card(color: .green, name: "Сбербанк"),
            Card(color: UIColor.yellow.withAlphaComponent(0.9), name: "Tinkoff")
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
        setupCards()
        setupSecondStack()
        
        // collectionView setup
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "CardCell", bundle: nil), forCellWithReuseIdentifier: cellId)
        collectionView.reloadData()
        
        // pageControl setup
//        pageControl.numberOfPages = cards.count
//        pageControl.tintColor = .red
//        pageControl.pageIndicatorTintColor = .blue
//        pageControl.currentPage = 0
//        pageControl.currentPageIndicatorTintColor = .red
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
        secondCard.separator.isHidden = true
        stackView.addArrangedSubview(secondCard)
    }
    
    func setupSecondStack() {
        let first: MainView = MainView.loadFromNib()
        first.cardImage.image = UIImage(named: "truecost")
        first.cardName.text = "True Cost"
        first.moneyAmount.text = ""
        secondStackView.addArrangedSubview(first)
        let second: MainView = MainView.loadFromNib()
        second.cardImage.image = UIImage(named: "hawksworth")
        second.cardName.text = "Hawksworth"
        second.moneyAmount.text = ""
        second.separator.isHidden = true
        secondStackView.addArrangedSubview(second)
    }

}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cardCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CardCell
        cardCell.configure(color: cards[indexPath.row].color, name: cards[indexPath.row].name)
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
        return UIEdgeInsets(top: 0, left: 6, bottom: 0, right: 6)
    }
}

