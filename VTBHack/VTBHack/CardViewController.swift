//
//  CardViewController.swift
//  VTBHack
//
//  Created by Roman Nordshtrem on 14/09/2019.
//  Copyright © 2019 RxProject. All rights reserved.
//

import UIKit

struct Card {
    var a: String
    var b: String
    var c: UIColor
    
    static func getData() -> [Card] {
        return [
            Card(a: "a", b: "b", c: .red),
            Card(a: "a1", b: "b1", c: .green),
            Card(a: "a2", b: "b2", c: .blue)
        ]
    }
}

class CardViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    private var cards = Card.getData()
    private let cellId = "cardCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // collectionView setup
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "CardCell", bundle: nil), forCellWithReuseIdentifier: cellId)
        collectionView.reloadData()
        
        // pageControl setup
        pageControl.numberOfPages = cards.count
        pageControl.tintColor = .red
        pageControl.pageIndicatorTintColor = .blue
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = .red
    }

}

extension CardViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cardCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CardCell
        cardCell.configure(card: cards[indexPath.row])
        return cardCell
    }
}

extension CardViewController: UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let center = CGPoint(x: scrollView.contentOffset.x + (scrollView.frame.width / 2), y: (scrollView.frame.height / 2))
        if let ip = collectionView.indexPathForItem(at: center) {
            pageControl.currentPage = ip.row
        }
    }
}

extension CardViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
