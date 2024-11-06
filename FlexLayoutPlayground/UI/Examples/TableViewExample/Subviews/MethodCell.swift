//
//  MethodCell.swift
//  FlexLayoutPlayground
//
//  Created by 김정민 on 11/6/24.
//

import UIKit
import FlexLayout
import PinLayout

final class MethodCell: UITableViewCell {
    
    private let padding: CGFloat = 10
    
    private let nameLabel = UILabel()
    private let descriptionLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        separatorInset = .zero
        
        let iconImageView = UIImageView(image: UIImage(named: "method"))
        
        self.nameLabel.font = .boldSystemFont(ofSize: 14)
        self.nameLabel.lineBreakMode = .byTruncatingTail
        
        self.descriptionLabel.font = .systemFont(ofSize: 12)
        self.descriptionLabel.numberOfLines = 0
        
        // Use contentView as the root flex container
        contentView.flex.padding(12).define { flex in
            flex.addItem().direction(.row).define { flex in
                flex.addItem(iconImageView).size(30)
                flex.addItem(self.nameLabel).marginLeft(self.padding).grow(1)
            }
            
            flex.addItem(self.descriptionLabel).marginTop(self.padding)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layout()
    }
    
    private func layout() {
        contentView.flex.layout(mode: .adjustHeight)
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        // 1) Set the contentView's width to the specified size paramter
        contentView.pin.width(size.width)
        
        // 2) Layout contentView flex container
        self.layout()
        
        // Return the flex container new size
        return contentView.frame.size
    }
    
    func configure(method: Method) {
        // WARNING: After a control size may have been modified after a change, you must call flex.markDirty() to force fix to relayout the view. This is due to the high level of optimization of FlexLayout.
        self.nameLabel.text = method.name
        self.nameLabel.flex.markDirty()
        
        self.descriptionLabel.text = method.description
        self.descriptionLabel.flex.markDirty()
    }
}
