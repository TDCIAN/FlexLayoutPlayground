//
//  Example1View.swift
//  FlexLayoutPlayground
//
//  Created by 김정민 on 11/9/24.
//

import UIKit
import FlexLayout
import PinLayout

final class Example1View: UIView {
    
    private let rootFlexContainer = UIView()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        
        let view1 = BasicView(text: "View 1")
        let view2 = BasicView(text: "View 2")
        let view3 = BasicView(text: "View 3")
        
        self.rootFlexContainer.flex.justifyContent(.center).padding(10).define { flex in
            flex.addItem(view1).height(40)
            flex.addItem(view2).height(40).marginTop(10)
            flex.addItem(view3).height(40).marginTop(10)
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
        self.rootFlexContainer.pin.all(self.pin.safeArea)
        
        // Then let the flexbox container layout itself
        self.rootFlexContainer.flex.layout()
    }
}

