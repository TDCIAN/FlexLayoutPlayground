//
//  YogaExampleAView.swift
//  FlexLayoutPlayground
//
//  Created by 김정민 on 11/11/24.
//

import UIKit
import FlexLayout
import PinLayout

final class YogaExampleAView: UIView {
    
    private let rootFlexContainer = UIView()
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .white
        
        self.rootFlexContainer.flex.direction(.row).padding(20).define { flex in
            flex.addItem().width(80).marginEnd(20).backgroundColor(.flexLayoutColor)
            flex.addItem().height(25).alignSelf(.center).grow(1).backgroundColor(.black)
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
        self.rootFlexContainer.pin.top(self.pin.safeArea).horizontally(self.pin.safeArea).height(120)
        
        // Then let the flexbox container layout itself
        self.rootFlexContainer.flex.layout()
    }
}
