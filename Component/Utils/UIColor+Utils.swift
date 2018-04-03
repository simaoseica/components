//
//  UIColor+Utils.swift
//  Component
//
//  Created by Simão Seiça  on 03/04/2018.
//

import Foundation
import UIKit

public extension UIColor {

    public convenience init(hex: UInt, alpha: CGFloat = 1.0) {

        self.init(red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
                  blue:  CGFloat(hex & 0x0000FF) / 255.0,
                  alpha: alpha)
    }
}
