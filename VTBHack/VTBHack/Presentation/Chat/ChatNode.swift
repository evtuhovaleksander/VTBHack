//
//  ChatNode.swift
//  VTBHack
//
//  Created by Nikita Arutyunov on 15.09.2019.
//  Copyright © 2019 RxProject. All rights reserved.
//

import AsyncDisplayKit

class ChatNode: RFDisplayNode {
  
  let messagesTableNode: ASTableNode = {
    
    let node = ASTableNode(style: .plain)
    
    node.style.preferredLayoutSize = ASLayoutSize(
      width: ASDimension(unit: .fraction, value: 1),
      height: ASDimension(unit: .fraction, value: 1)
    )
    
    node.backgroundColor = .clear
    
    node.view.separatorStyle = .none
    
    return node
    
  }()
  
  let newMessageNode: NewMessageNode = {
    
    let node = NewMessageNode()
    
    node.style.preferredLayoutSize = ASLayoutSize(
      width: ASDimension(unit: .fraction, value: 1),
      height: ASDimension(unit: .points, value: 52)
    )
    
    node.backgroundColor = .white
    
    node.border = RFBorder(radius: 27)
    
    node.shadow = RFShadow(
      color: UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 1),
      radius: 14,
      opacity: 0.4,
      offset: CGSize(width: 0, height: 2)
    )
    
    return node
    
  }()
  
  override init() {
    
    super.init()
    
    automaticallyManagesSubnodes = true
    
    backgroundColor = UIColor(displayP3Red: 248/255, green: 248/255, blue: 248/255, alpha: 1)
    
  }
  
  override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    
    let stack = ASStackLayoutSpec.vertical()
    
    stack.children = [
      ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 0, bottom: 92, right: 0), child: messagesTableNode),
      ASInsetLayoutSpec(insets: UIEdgeInsets(top: -72, left: 12, bottom: 20, right: 12), child: newMessageNode)
    ]
    
    return stack
    
  }
  
}
