//
//  MethodGroupHeader.swift
//  FlexLayoutPlayground
//
//  Created by 김정민 on 11/6/24.
//

import UIKit

final class MethodGroupHeader: UITableViewHeaderFooterView {
    
    static let height: CGFloat = 50
    
    fileprivate let titleLabel = UILabel()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        self.titleLabel.font = .systemFont(ofSize: 20)
        self.titleLabel.sizeToFit()
        addSubview(self.titleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Center the label vertically. Note that we don't need to specify the size, it has already be adjusted in init().
        self.titleLabel.pin.horizontally(pin.safeArea.left + 12).vCenter()
    }
    
    func configure(title: String) {
        self.titleLabel.text = title
        self.titleLabel.sizeToFit()
    }
}
