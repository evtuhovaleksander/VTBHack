//
//  ChatController+DataSource.swift
//  VTBHack
//
//  Created by Nikita Arutyunov on 15.09.2019.
//  Copyright © 2019 RxProject. All rights reserved.
//

import AsyncDisplayKit

extension ChatController: ASTableDataSource {
  
  func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
    
    return testCells.count
    
  }
  
  func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
    
    return testCells[indexPath.item]
    
  }
  
}
