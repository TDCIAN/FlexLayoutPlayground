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
        
        self.label.text = text
        self.label.font = .systemFont(ofSize: 14)
        self.label.textColor = .white
        self.label.numberOfLines = 0
        self.label.sizeToFit()
        self.addSubview(self.label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.label.pin.center()
    }
    
    var sizeThatFitsExpectedArea: CGFloat = 40 * 40
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var newSize = CGSize()
        if size.width != CGFloat.greatestFiniteMagnitude {
            newSize.width = size.width
            newSize.height = self.sizeThatFitsExpectedArea / newSize.width
        } else if size.height != CGFloat.greatestFiniteMagnitude {
            newSize.height = size.height
            newSize.width = self.sizeThatFitsExpectedArea / newSize.height
        } else {
            newSize.width = 40
            newSize.height = self.sizeThatFitsExpectedArea / newSize.width
        }
        
        return newSize
    }
}
