//
//  IntroView.swift
//  FlexLayoutPlayground
//
//  Created by 김정민 on 11/3/24.
//

import UIKit
import FlexLayout
import PinLayout

final class IntroView: UIView {
    fileprivate let rootFlexContainer = UIView()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "flexlayout-logo"))
        imageView.layer.borderColor = UIColor.red.cgColor
        imageView.layer.borderWidth = 1
        return imageView
    }()
    
    private lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Intro", "FlexLayout", "PinLayout"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.layer.borderColor = UIColor.blue.cgColor
        segmentedControl.layer.borderWidth = 1
        return segmentedControl
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Flexbox layouting is simple, powerfull and fast.\nFlexLayout syntax is concise and chainable."
        label.numberOfLines = 0
        label.layer.borderColor = UIColor.green.cgColor
        label.layer.borderWidth = 1
        return label
    }()
    
    private lazy var bottomLabel: UILabel = {
        let bottomLabel = UILabel()
        bottomLabel.text = "FlexLayout/yoga is incredibly fast, its even faster than manual layout."
        bottomLabel.numberOfLines = 0
        bottomLabel.layer.borderColor = UIColor.yellow.cgColor
        bottomLabel.layer.borderWidth = 1
        return bottomLabel
    }()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(self.rootFlexContainer)
        
        self.rootFlexContainer.flex.direction(.column).padding(12).define { flex in
            flex.addItem().direction(.row).define { flex in
                flex.addItem(self.imageView).width(100).aspectRatio(of: self.imageView)
                
                flex.addItem().direction(.column).paddingLeft(12).grow(1).shrink(1).define { flex in
                    flex.addItem(self.segmentedControl).marginBottom(12)
                    flex.addItem(self.label)
                }
            }
            
            flex.addItem().height(1).marginTop(12).backgroundColor(.lightGray)
            flex.addItem(self.bottomLabel).marginTop(12).height(100)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.rootFlexContainer.pin.top().horizontally().margin(pin.safeArea)
        self.rootFlexContainer.flex.layout(mode: .adjustHeight)
    }
}
