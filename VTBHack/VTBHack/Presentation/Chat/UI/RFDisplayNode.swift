//
//  RFDisplayNode.swift
//  RFUI
//
//  Created by Nikita Arutyunov on 01/03/2019.
//  Copyright © 2019 Nikita Arutyunov. All rights reserved.
//

import AsyncDisplayKit

open class RFDisplayNode: ASDisplayNode {
  
  open var insets = UIEdgeInsets.zero
  
  open var insetSpec: ASInsetLayoutSpec {
    
    return ASInsetLayoutSpec(insets: insets, child: self)
    
  }
  
  open var centerSpec: ASCenterLayoutSpec {
    
    return ASCenterLayoutSpec(
      horizontalPosition: .center,
      verticalPosition: .center,
      sizingOption: .minimumSize,
      child: self
    )
    
  }
  
  open var size: ASLayoutSize {
    
    get {
      
      return style.preferredLayoutSize
      
    }
    
    set {
      
      style.preferredLayoutSize = newValue
      
    }
    
  }
  
  open var shadow: RFShadow {
    
    get {
      
      let shadowColor = UIColor(cgColor: self.shadowColor ?? UIColor.clear.cgColor)
      
      return RFShadow(color: shadowColor, radius: shadowRadius, opacity: shadowOpacity, offset: shadowOffset)
    
    }
    
    set {
      
      clipsToBounds = false
      
      shadowColor = newValue.color.cgColor
      shadowRadius = newValue.radius
      shadowOpacity = newValue.opacity
      shadowOffset = newValue.offset
      
    }
    
  }
  
  open var border: RFBorder {
    
    get {
      
      let borderColor = UIColor(cgColor: self.borderColor ?? UIColor.clear.cgColor)
      
      return RFBorder(color: borderColor, width: borderWidth, radius: cornerRadius)
      
    }
    
    set {
      
      borderColor = newValue.color.cgColor
      borderWidth = newValue.width
      
      cornerRadius = newValue.radius
      
    }
    
  }
  
}
