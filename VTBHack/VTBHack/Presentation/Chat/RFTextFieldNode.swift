//
//  RFTextFieldNode.swift
//  RFUI
//
//  Created by Nikita Arutyunov on 01/03/2019.
//  Copyright © 2019 Nikita Arutyunov. All rights reserved.
//

import AsyncDisplayKit

open class RFTextFieldNode: ASEditableTextNode {
  
  open var attributes = [NSAttributedString.Key: Any]()
  
  open var placeholderAttributes = [NSAttributedString.Key: Any]()
  
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
  
  open var multipleLines = true
  
  public override init() {
    
    super.init()
    
    delegate = self
    
  }
  
  public override init(textKitComponents: ASTextKitComponents, placeholderTextKitComponents: ASTextKitComponents) {
    
    super.init(textKitComponents: textKitComponents, placeholderTextKitComponents: placeholderTextKitComponents)
    
    delegate = self
    
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
    
    let typingAttributes = Dictionary(uniqueKeysWithValues:
      self.attributes.lazy.map { ($0.key.rawValue, $0.value) }
    )
    
    self.typingAttributes = typingAttributes
    
  }
  
  open func setPlaceholderAttributes(_ attributes: RFTextAttributes) {
    
    if let color = attributes.color {
      
      self.placeholderAttributes[NSAttributedString.Key.foregroundColor] = color
      
    }
    
    if let font = attributes.font {
      
      self.placeholderAttributes[NSAttributedString.Key.font] = font
      
    }
    
    if let letterSpacing = attributes.letterSpacing {
      
      self.placeholderAttributes[NSAttributedString.Key.kern] = letterSpacing
      
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
    
    self.placeholderAttributes[NSAttributedString.Key.paragraphStyle] = paragraphStyle
    
  }
  
  open func setAttributedText(_ text: String) {
    
    let attributedText = NSAttributedString(string: text, attributes: attributes)
    
    self.attributedText = attributedText
    
  }
  
  open func setPlaceholderAttributedText(_ text: String) {
    
    let attributedText = NSAttributedString(string: text, attributes: placeholderAttributes)
    
    self.attributedPlaceholderText = attributedText
    
  }
  
  open func appendAttributedText(_ text: String) {
    
    let attributedText = NSMutableAttributedString()
    
    let oldAttributedText = self.attributedText ?? NSAttributedString()
    
    attributedText.append(oldAttributedText)
    
    let newAttributedText = NSAttributedString(string: text, attributes: attributes)
    
    attributedText.append(newAttributedText)
    
    self.attributedText = attributedText
    
  }
  
  open func appendPlaceholderAttributedText(_ text: String) {
    
    let attributedText = NSMutableAttributedString()
    
    let oldAttributedText = self.attributedPlaceholderText ?? NSAttributedString()
    
    attributedText.append(oldAttributedText)
    
    let newAttributedText = NSAttributedString(string: text, attributes: placeholderAttributes)
    
    attributedText.append(newAttributedText)
    
    self.attributedPlaceholderText = attributedText
    
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
  
  open func appendPlaceholderAttributedText(_ text: String, _ attributes: RFTextAttributes) {
    
    let oldAttributes = self.placeholderAttributes
    
    let attributedText = NSMutableAttributedString()
    
    let oldAttributedText = self.attributedPlaceholderText ?? NSAttributedString()
    
    attributedText.append(oldAttributedText)
    
    setAttributes(attributes)
    
    let newAttributedText = NSAttributedString(string: text, attributes: self.placeholderAttributes)
    
    attributedText.append(newAttributedText)
    
    self.attributedPlaceholderText = attributedText
    
    self.placeholderAttributes = oldAttributes
    
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
  
}

extension RFTextFieldNode: ASEditableTextNodeDelegate {
  
  open func obtainNewText(_ text: String) -> Bool {
    
    let isNewLine = text.contains("\n")
    
    if isNewLine && !multipleLines {
      
      var trimmedText = text
      
      trimmedText.removeAll(where: { $0 == "\n" })
      
      appendAttributedText(trimmedText)
      
      return false
      
    }
    
    return true
    
  }
  
  open func editableTextNode(_ editableTextNode: ASEditableTextNode,
                             shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    
    return obtainNewText(text)
    
  }
  
  open func editableTextNodeShouldBeginEditing(_ editableTextNode: ASEditableTextNode) -> Bool { return true }
  
  open func editableTextNodeDidBeginEditing(_ editableTextNode: ASEditableTextNode) { }
  
  open func editableTextNodeDidUpdateText(_ editableTextNode: ASEditableTextNode) { }
  
  open func editableTextNodeDidFinishEditing(_ editableTextNode: ASEditableTextNode) { }
  
  open func editableTextNodeDidChangeSelection(_ editableTextNode: ASEditableTextNode, fromSelectedRange: NSRange,
                                               toSelectedRange: NSRange, dueToEditing: Bool) { }
  
}
