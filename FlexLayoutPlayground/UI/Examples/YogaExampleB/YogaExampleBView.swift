//
//  YogaExampleBView.swift
//  FlexLayoutPlayground
//
//  Created by 김정민 on 11/11/24.
//

import UIKit
import FlexLayout
import PinLayout

final class YogaExampleBView: UIView {
    
    private let rootFlexContainer = UIView()
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .white
        
        let imageView = UIView()
        imageView.backgroundColor = .flexLayoutColor
        
        let label = UIView()
        label.backgroundColor = .black
    
        // Yoga's Objective-C Example
        self.rootFlexContainer.flex.alignItems(.center).justifyContent(.center).padding(20).define { flex in
            flex.addItem(imageView).size(150).aspectRatio(1).marginBottom(20)
            flex.addItem(label).width(100).height(25)
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
        self.rootFlexContainer.pin.top(self.pin.safeArea).horizontally(self.pin.safeArea).height(200)
        
        // Then let the flexbox container layout itself
        self.rootFlexContainer.flex.layout()
    }
}
