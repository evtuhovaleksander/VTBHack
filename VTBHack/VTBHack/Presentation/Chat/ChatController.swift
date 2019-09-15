//
//  ChatController.swift
//  VTBHack
//
//  Created by Nikita Arutyunov on 15.09.2019.
//  Copyright © 2019 RxProject. All rights reserved.
//

import AsyncDisplayKit

class ChatController: ASViewController<ChatNode> {
  
  let testCells: [ASCellNode] = [
    ChatDateNode(
      ChatDateModel(date: "13 сентября"),
      insets: UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
    ),
    UserMessageNode(
      ChatMessageModel(author: "1", text: "Привет ✋", time: "13:07"),
      insets: UIEdgeInsets(top: 0, left: 0, bottom: 4, right: 0)
    ),
    UserMessageNode(
      ChatMessageModel(author: "1", text: "Ну что? Разделим чек?", time: "13:07"),
      insets: UIEdgeInsets(top: 0, left: 0, bottom: 4, right: 0)
    ),
    StrangerMessageNode(
      ChatMessageModel(author: "2", text: "Привет! Давай)", time: "13:46"),
      insets: UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
    ),
    UserMessageNode(
      ChatMessageModel(author: "1", text: "Сейчас скину свои продукты из чека", time: "13:47"),
      insets: UIEdgeInsets(top: 0, left: 0, bottom: 4, right: 0)
    ),
    ChatActionNode(
      ChatActionModel(author: "Андрей Семенов", action: "оплатил счет"),
      insets: UIEdgeInsets(top: 24, left: 0, bottom: 24, right: 0)
    ),
  ]
  
  init() {
    
    super.init(node: ChatNode())
    
    node.messagesTableNode.dataSource = self
    
  }
  
  required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
  
}
