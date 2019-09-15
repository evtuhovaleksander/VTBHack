//
//  MenuViewController.swift
//  VTBHack
//
//  Created by Aleksander Evtuhov on 15/09/2019.
//  Copyright © 2019 RxProject. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    @IBOutlet var stackView: UIStackView!
    @IBOutlet var containerView: UIView!
    
    @IBOutlet var snapImageView: UIImageView!
    
    var snapImage: UIImage?
    
    class func getController(titles:[String],actions: [VoidBlock?]) -> MenuViewController {
        let board = UIStoryboard(name: "Menu", bundle: nil)
        let controller = board.instantiateInitialViewController() as! MenuViewController
        controller.actions = actions
        controller.titles = titles
        controller.actions.append {}
        controller.titles.append("Закрыть")
        return controller
    }
    
    var titles = [String]()
    var actions = [VoidBlock?]()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        snapImageView.image = snapImage
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .clear
        for i in 0 ..< titles.count {
            let item: MenuView = MenuView.loadFromNib()
            item.action = {
                let action = self.actions[i]
                //action()
                self.dismiss(animated: true, completion: {
                    action?()
                    self.removeFromParent()
                    self.view.removeFromSuperview()
                })
            }
            item.button.setTitle(titles[i], for: .normal)
            stackView.addArrangedSubview(item)
        }
        (stackView.arrangedSubviews.last as? MenuView)?.separator.isHidden = true
        stackView.backgroundColor = .clear
        containerView.backgroundColor = UIColor.Color.backgroundGray
        containerView.layer.cornerRadius = 20.0
        containerView.clipsToBounds = true
    }
}

extension UIViewController {
    
    func showMenu(titles:[String],actions: [VoidBlock]) {
        
        
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        
        let cnt = MenuViewController.getController(titles: titles, actions: actions)
        cnt.snapImage = image
        present(cnt, animated: true, completion: nil)
    }
    
//    func showMenu(titles:[String],actions: [VoidBlock]) {
//        let cnt = MenuViewController.getController(titles: titles, actions: actions)
//        view.addSubview(cnt.view)
//        cnt.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
//        cnt.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
//        cnt.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//
//        cnt.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//
//        cnt.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//        addChild(cnt)
//        cnt.didMove(toParent: self)
//    }
    
//    func showMenu2(titles:[String],actions: [VoidBlock]) {
//
//
//            UIGraphicsBeginImageContext(view.frame.size)
//            view.layer.render(in: UIGraphicsGetCurrentContext()!)
//            let image = UIGraphicsGetImageFromCurrentImageContext()
//            UIGraphicsEndImageContext()
//
//
//        let cnt = MenuViewController.getController(titles: titles, actions: actions)
//        cnt.snapImage = image
//        present(cnt, animated: true, completion: nil)
//    }
}
