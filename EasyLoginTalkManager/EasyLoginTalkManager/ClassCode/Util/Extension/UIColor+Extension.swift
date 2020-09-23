//
//  UIColor+Extension.swift
//  EasyLoginTalkManager
//
//  Created by Nguyễn Trung on 9/22/20.
//  Copyright © 2020 Nguyễn Trung. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(hex: Int, alpha: CGFloat = 1) {
        self.init(red: CGFloat(((hex >> 16) & 0xFF)), green: CGFloat(((hex >> 8) & 0xFF)), blue: CGFloat((hex & 0xFF)), alpha: alpha)
    }
}
