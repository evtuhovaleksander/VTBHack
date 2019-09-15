//
//  RFTextAttributes.swift
//  VTBHack
//
//  Created by Nikita Arutyunov on 15.09.2019.
//  Copyright © 2019 RxProject. All rights reserved.
//

import UIKit

public struct RFTextAttributes {
  
  public var color: UIColor?
  public var font: UIFont?
  public var letterSpacing: NSNumber?
  public var lineHeight: CGFloat?
  public var alignment: NSTextAlignment?
  public var lineBreak: NSLineBreakMode?
  
  public init(color: UIColor?, font: UIFont?, letterSpacing: Double? = nil,
              lineHeight: CGFloat? = nil, alignment: NSTextAlignment? = nil, lineBreak: NSLineBreakMode? = nil) {
    
    self.color = color
    self.font = font
    
    if let letterSpacing = letterSpacing {
      
      self.letterSpacing = NSNumber(floatLiteral: letterSpacing)
      
    }
    
    self.lineHeight = lineHeight
    self.alignment = alignment
    self.lineBreak = lineBreak
    
  }
  
}
