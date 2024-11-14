//
//  YogaExampleDView.swift
//  FlexLayoutPlayground
//
//  Created by 김정민 on 11/14/24.
//

import UIKit
import FlexLayout
import PinLayout

final class YogaExampleDView: UIView {
    
    private let rootFlexContainer = UIView()
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .white
        
        let imageView = UIView()
        imageView.backgroundColor = .flexLayoutColor
        
        let label = UIView()
        label.backgroundColor = .black
        
        // Yoga's C# example
        self.rootFlexContainer.flex.justifyContent(.start).alignItems(.start).define { flex in
            flex.addItem(imageView).alignSelf(.stretch).grow(1)
            flex.addItem(label).width(300).height(25).margin(20)
        }
        self.addSubview(self.rootFlexContainer)
        
        self.rootFlexContainer.layer.borderColor = UIColor.red.cgColor
        self.rootFlexContainer.layer.borderWidth = 1
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
