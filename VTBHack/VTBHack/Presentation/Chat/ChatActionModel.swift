//
//  ChatActionModel.swift
//  VTBHack
//
//  Created by Nikita Arutyunov on 15.09.2019.
//  Copyright © 2019 RxProject. All rights reserved.
//

import Foundation

struct ChatActionModel {
  
  let author: String
  let action: String
  
  init(author: String, action: String) {
    
    self.author = author
    self.action = action
    
  }
  
}
