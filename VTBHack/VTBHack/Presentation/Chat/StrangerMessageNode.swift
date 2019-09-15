//
//  UserMessageNode.swift
//  VTBHack
//
//  Created by Nikita Arutyunov on 15.09.2019.
//  Copyright © 2019 RxProject. All rights reserved.
//

import AsyncDisplayKit

class StrangerMessageNode: ASCellNode {
  
  let model: ChatMessageModel
  
  let insets: UIEdgeInsets
  
  let containerNode: RFDisplayNode = {
    
    let node = RFDisplayNode()
    
    node.style.height = ASDimension(unit: .fraction, value: 1.0)
    node.style.maxWidth = ASDimension(unit: .fraction, value: 0.65)
    
    node.backgroundColor = .white
    node.border = RFBorder(radius: 20)
    
    return node
    
  }()
  
  let textNode: RFTextNode = {
    
    let node = RFTextNode()
    
    node.setAttributes(RFTextAttributes(
      color: UIColor(displayP3Red: 60/255, green: 60/255, blue: 60/255, alpha: 1),
      font: .systemFont(ofSize: 15, weight: .medium)
    ))
    
    node.style.flexShrink = 1.0
    
    return node
    
  }()
  
  let timeNode: RFTextNode = {
    
    let node = RFTextNode()
    
    node.setAttributes(RFTextAttributes(
      color: UIColor(displayP3Red: 190/255, green: 190/255, blue: 190/255, alpha: 1),
      font: .systemFont(ofSize: 13, weight: .light)
    ))
    
    return node
    
  }()
  
  init(_ model: ChatMessageModel, insets: UIEdgeInsets) {
    
    self.model = model
    
    self.insets = insets
    
    timeNode.setAttributedText(model.time)
    textNode.setAttributedText(model.text)
    
    super.init()
    
    automaticallyManagesSubnodes = false
    
    containerNode.addSubnode(textNode)
    
    addSubnode(timeNode)
    addSubnode(containerNode)
    
  }
  
  override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    
    containerNode.layoutSpecBlock = { [weak self] (_, _) in

      guard let `self` = self else { return ASLayoutSpec() }

      return ASInsetLayoutSpec(
        insets: UIEdgeInsets(top: 11, left: 16, bottom: 11, right: 16),
        child: self.textNode.centerSpec
      )

    }
    
    let stack = ASStackLayoutSpec.horizontal()
    
    stack.horizontalAlignment = .left
    stack.verticalAlignment = .center
    
    stack.children = [
      ASInsetLayoutSpec(
        insets: UIEdgeInsets(top: insets.top, left: 16, bottom: insets.bottom, right: 0),
        child: containerNode
      ),
      ASInsetLayoutSpec(
        insets: UIEdgeInsets(top: insets.top, left: 8, bottom: insets.bottom, right: 0),
        child: timeNode
      ),
    ]
    
    return stack
    
  }
  
}
