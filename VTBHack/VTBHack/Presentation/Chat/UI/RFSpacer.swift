//
//  RFSpacer.swift
//  RFUI
//
//  Created by Nikita Arutyunov on 01/03/2019.
//  Copyright © 2019 Nikita Arutyunov. All rights reserved.
//

import AsyncDisplayKit

public var RFSpacer: ASLayoutSpec {
  
  return RFSpacerSpec()
  
}

internal class RFSpacerSpec: ASLayoutSpec {
  
  internal override init() {
    
    super.init()
    
    style.flexGrow = 1.0
    
  }
  
}
