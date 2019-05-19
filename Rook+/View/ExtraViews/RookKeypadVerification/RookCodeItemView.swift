//
//  RookCodeItemView.swift
//  Rook+
//
//  Created by Delmwin Baeka on 1/30/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import UIKit

open class RookCodeTextField: UITextField {
    override open func becomeFirstResponder() -> Bool {
        return false
    }
}

