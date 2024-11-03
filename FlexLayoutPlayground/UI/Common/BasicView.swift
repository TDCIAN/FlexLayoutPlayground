//
//  BasicView.swift
//  FlexLayoutPlayground
//
//  Created by 김정민 on 11/3/24.
//

import UIKit
import PinLayout

class BasicView: UIView {
    fileprivate let label = UILabel()
    
    init(text: String? = nil) {
        super.init(frame: .zero)
        
        backgroundColor = UIColor.systemOrange
        layer.borderColor = UIColor.green.cgColor
        layer.borderWidth = 2
        
        label.text = text
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white
        label.numberOfLines = 0
        label.sizeToFit()
        addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        label.pin.center()
    }
    
    var sizeThatFitsExpectedArea: CGFloat = 40 * 40
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var newSize = CGSize()
        if size.width != CGFloat.greatestFiniteMagnitude {
            newSize.width = size.width
            newSize.height = sizeThatFitsExpectedArea / newSize.width
        } else if size.height != CGFloat.greatestFiniteMagnitude {
            newSize.height = size.height
            newSize.width = sizeThatFitsExpectedArea / newSize.height
        } else {
            newSize.width = 40
            newSize.height = sizeThatFitsExpectedArea / newSize.width
        }
        
        return newSize
    }
}
