//
//  NewMessageNode.swift
//  VTBHack
//
//  Created by Nikita Arutyunov on 15.09.2019.
//  Copyright © 2019 RxProject. All rights reserved.
//

import AsyncDisplayKit

class NewMessageNode: RFDisplayNode {
  
  let textNode: RFTextFieldNode = {
    
    let node = RFTextFieldNode()
    
    node.setAttributes(RFTextAttributes(
      color: UIColor(displayP3Red: 60/255, green: 60/255, blue: 60/255, alpha: 1),
      font: .systemFont(ofSize: 17, weight: .regular)
    ))
    
    node.setPlaceholderAttributes(RFTextAttributes(
      color: UIColor(displayP3Red: 190/255, green: 190/255, blue: 190/255, alpha: 1),
      font: .systemFont(ofSize: 17, weight: .regular)
    ))
    
    node.setPlaceholderAttributedText("Введите сообщение")
    
    return node
    
  }()
  
  let sendButtonNode: ASButtonNode = {
    
    let node = ASButtonNode()
    
    node.style.preferredLayoutSize = ASLayoutSize(
      width: ASDimension(unit: .points, value: 52),
      height: ASDimension(unit: .points, value: 52)
    )
    
    node.setImage(UIImage(named: "chatSend"), for: .normal) // FIXME: Иконка в ассетах не по центру
    
    return node
    
  }()
  
  override init() {
    
    super.init()
    
    automaticallyManagesSubnodes = true
    
  }
  
  override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    
    let stack = ASStackLayoutSpec.horizontal()
    
    stack.verticalAlignment = .center
    
    stack.children = [
      ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 0), child: textNode),
      RFSpacer,
      ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), child: sendButtonNode)
    ]
    
    return stack
    
  }
  
}
