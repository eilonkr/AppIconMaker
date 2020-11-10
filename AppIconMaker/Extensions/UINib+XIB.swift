//
//  UIView+XIB.swift
//  AppIconMaker
//
//  Created by Eilon Krauthammer on 10/11/2020.
//

import UIKit

extension UIView {
   static var nib: UINib {
      return UINib(nibName: "\(self)", bundle: nil)
   }

   static func fromNib() -> Self? {
      return nib.instantiate() as? Self
   }
}

extension UINib {
   func instantiate() -> Any? {
      return instantiate(withOwner: nil, options: nil).first
   }
}

