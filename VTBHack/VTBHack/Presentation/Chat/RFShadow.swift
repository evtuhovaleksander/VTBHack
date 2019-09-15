//
//  RFShadow.swift
//  RFUI
//
//  Created by Nikita Arutyunov on 16/03/2019.
//  Copyright © 2019 Nikita Arutyunov. All rights reserved.
//

import UIKit

public struct RFShadow {

  public let color: UIColor
  public let radius: CGFloat
  public let opacity: CGFloat
  public let offset: CGSize

  public init(color: UIColor = .clear, radius: CGFloat = 0, opacity: CGFloat = 0, offset: CGSize = .zero) {

    self.color = color
    self.radius = radius
    self.opacity = opacity
    self.offset = offset

  }

}
