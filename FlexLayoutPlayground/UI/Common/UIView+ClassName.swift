//
//  UIView+ClassName.swift
//  FlexLayoutPlayground
//
//  Created by 김정민 on 11/3/24.
//

import UIKit

extension UIView {
    static var className: String {
        String(describing: type(of: self))
    }
}
