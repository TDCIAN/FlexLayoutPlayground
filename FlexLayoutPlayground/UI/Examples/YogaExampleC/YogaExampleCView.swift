//
//  YogaExampleCView.swift
//  FlexLayoutPlayground
//
//  Created by 김정민 on 11/14/24.
//

import UIKit
import FlexLayout
import PinLayout

final class YogaExampleCView: UIView {
    private let rootFlexContainer = UIView()
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .white
        
        
        let label = UIView()
        label.backgroundColor = .black
        
        let imageView = UIImageView()
        imageView.backgroundColor = .flexLayoutColor
        
        self.rootFlexContainer.layer.borderColor = UIColor.red.cgColor
        self.rootFlexContainer.layer.borderWidth = 1
        
        // Yoga's Java Example
        self.rootFlexContainer.flex.alignItems(.center).justifyContent(.center).padding(20).define { flex in
            flex.addItem(label).width(200).height(25)
            flex.addItem(imageView).position(.absolute).top(20).end(20).size(50)
        }
        self.addSubview(self.rootFlexContainer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Layout the flexbox container using PinLayout
        // NOTE: Could be also layouted by setting directly rootFlexContainer.frame
        self.rootFlexContainer.pin.top(self.pin.safeArea).horizontally(self.pin.safeArea).height(300)
        
        // Then let the flexbox container layout itself
        self.rootFlexContainer.flex.layout()
    }
}
