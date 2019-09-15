//
//  PeopleSelector.swift
//  VTBHack
//
//  Created by Aleksander Evtuhov on 15/09/2019.
//  Copyright © 2019 RxProject. All rights reserved.
//

import UIKit

class PeopleSelectorView: UIView {
    @IBOutlet var stackView: UIStackView!
    @IBOutlet var containerView: UIView!
    var selectedBlock: ((Int)->())?
    override func awakeFromNib() {
        super.awakeFromNib()
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    var expanded = false
    var currentIndex = 0
    var people = [Contact]()
    var views = [SelectorCell]()
    
    @objc func tapped(a: UITapGestureRecognizer) {
        guard let tappedView = a.view as? SelectorCell else { return }
        changeState(tappedView: tappedView)
    }
    
    func setup() {
        for v in stackView.arrangedSubviews {
            stackView.removeArrangedSubview(v)
        }
        for v in stackView.subviews {
            v.removeFromSuperview()
        }
        
        views = []
        
        for i in 0..<people.count {
            let menuView: SelectorCell = SelectorCell.loadFromNib()
            menuView.nickLabel.text = "\(people[i].nickName)"
            menuView.phoneLabel.text = "\(people[i].phone)"
            views.append(menuView)
            stackView.addArrangedSubview(menuView)
            let gesture = UITapGestureRecognizer(target: self, action: #selector(tapped(a:)))
            menuView.addGestureRecognizer(gesture)
            if i > 0 {
                menuView.isHidden = true
            }
        }
    }
    
    func changeState(tappedView: SelectorCell) {
        
        if expanded {
            UIView.animate(withDuration: 1.0) {
            self.currentIndex = self.views.index(of: tappedView) ?? 0
            for i in 0 ..< self.views.count {
                if i != self.currentIndex {
                    self.views[i].isHidden = true
                }
            }
            }
            selectedBlock?(currentIndex)
        } else {
            UIView.animate(withDuration: 1.0) {
                for v in self.views {
                    v.isHidden = false
                }
            }
        }
        expanded.toggle()
    }
}
