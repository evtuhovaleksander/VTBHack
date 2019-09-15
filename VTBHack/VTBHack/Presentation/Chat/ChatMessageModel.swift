//
//  ChatMessageModel.swift
//  VTBHack
//
//  Created by Nikita Arutyunov on 15.09.2019.
//  Copyright © 2019 RxProject. All rights reserved.
//

import Foundation

struct ChatMessageModel {
  
  let author: String
  let text: String
  let time: String
  
  init(author: String, text: String, time: String) {
    
    self.author = author
    self.text = text
    self.time = time
    
  }
  
}
