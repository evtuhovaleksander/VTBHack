//
//  ChatDateNode.swift
//  VTBHack
//
//  Created by Nikita Arutyunov on 15.09.2019.
//  Copyright © 2019 RxProject. All rights reserved.
//

import AsyncDisplayKit

class ChatDateNode: ASCellNode {
  
  let model: ChatDateModel
  
  let insets: UIEdgeInsets
  
  let textNode: RFTextNode = {
    
    let node = RFTextNode()
    
    node.setAttributes(RFTextAttributes(
      color: UIColor(displayP3Red: 190/255, green: 190/255, blue: 190/255, alpha: 1),
      font: .systemFont(ofSize: 13, weight: .light)
    ))
    
    return node
    
  }()
  
  init(_ model: ChatDateModel, insets: UIEdgeInsets) {
    
    self.model = model
    
    self.insets = insets
    
    textNode.setAttributedText(model.date)
    
    super.init()
    
    automaticallyManagesSubnodes = true
    
  }
  
  override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    
    return ASInsetLayoutSpec(insets: insets, child: textNode.centerSpec)
    
  }
  
}
