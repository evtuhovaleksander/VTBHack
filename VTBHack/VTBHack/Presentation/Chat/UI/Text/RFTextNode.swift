//
//  RFTextNode.swift
//  RFUI
//
//  Created by Nikita Arutyunov on 01/03/2019.
//  Copyright © 2019 Nikita Arutyunov. All rights reserved.
//

import AsyncDisplayKit

open class RFTextNode: ASTextNode {
  
  open var attributes = [NSAttributedString.Key: Any]()
  
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
  
  open func setAttributes(_ attributes: RFTextAttributes) {
    
    if let color = attributes.color {
      
      self.attributes[NSAttributedString.Key.foregroundColor] = color
      
    }
    
    if let font = attributes.font {
      
      self.attributes[NSAttributedString.Key.font] = font
      
    }
    
    if let letterSpacing = attributes.letterSpacing {
      
      self.attributes[NSAttributedString.Key.kern] = letterSpacing
      
    }
    
    let paragraphStyle = NSMutableParagraphStyle()
    
    if let lineHeight = attributes.lineHeight {
      
      paragraphStyle.maximumLineHeight = lineHeight
      paragraphStyle.minimumLineHeight = lineHeight
      
    }
    
    if let alignment = attributes.alignment {
      
      paragraphStyle.alignment = alignment
      
    }
    
    if let lineBreak = attributes.lineBreak {
      
      paragraphStyle.lineBreakMode = lineBreak
      
    }
    
    self.attributes[NSAttributedString.Key.paragraphStyle] = paragraphStyle
    
  }
  
  public func setAttributedText(_ text: String) {
    
    let attributedText = NSAttributedString(string: text, attributes: attributes)
    
    self.attributedText = attributedText
    
  }
  
  open func appendAttributedText(_ text: String) {
    
    let attributedText = NSMutableAttributedString()
    
    let oldAttributedText = self.attributedText ?? NSAttributedString()
    
    attributedText.append(oldAttributedText)
    
    let newAttributedText = NSAttributedString(string: text, attributes: attributes)
    
    attributedText.append(newAttributedText)
    
    self.attributedText = attributedText
    
  }
  
  open func appendAttributedText(_ text: String, _ attributes: RFTextAttributes) {
    
    let oldAttributes = self.attributes
    
    let attributedText = NSMutableAttributedString()
    
    let oldAttributedText = self.attributedText ?? NSAttributedString()
    
    attributedText.append(oldAttributedText)
    
    setAttributes(attributes)
    
    let newAttributedText = NSAttributedString(string: text, attributes: self.attributes)
    
    attributedText.append(newAttributedText)
    
    self.attributedText = attributedText
    
    self.attributes = oldAttributes
    
  }
  
  open func setStrikethrough(_ value: Int) {
    
    guard let attributedText = self.attributedText else { return }
    
    let newAttributedText = NSMutableAttributedString(attributedString: attributedText)
    
    newAttributedText.addAttribute(
      .strikethroughStyle,
      value: value,
      range: NSRange(location: 0, length: newAttributedText.length)
    )
    
    self.attributedText = newAttributedText
    
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
