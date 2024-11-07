//
//  HouseCell.swift
//  FlexLayoutPlayground
//
//  Created by 김정민 on 11/7/24.
//

import UIKit
import FlexLayout

final class HouseCell: UICollectionViewCell {
    private let nameLabel = UILabel()
    private let mainImage = UIImageView()
    private let priceLabel = UILabel()
    private let distanceLabel = UILabel()
    
    private let padding: CGFloat = 8
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let footerBackgroundColor = UIColor.flexLayoutColor.withAlphaComponent(0.2)
        backgroundColor = .white
        
        self.nameLabel.font = UIFont.systemFont(ofSize: 24)
        self.nameLabel.textColor = .white
        
        self.mainImage.backgroundColor = .black
        self.mainImage.contentMode = .scaleAspectFill
        self.mainImage.clipsToBounds = true
        
        self.distanceLabel.textAlignment = .right
        
        contentView.flex.define { flex in
            flex.addItem().backgroundColor(.flexLayoutColor).paddingHorizontal(self.padding).define { flex in
                flex.addItem(self.nameLabel).grow(1)
            }
            
            flex.addItem(self.mainImage).height(300)
            
            flex.addItem().direction(.row).justifyContent(.spaceBetween).padding(6, self.padding, 6, self.padding).backgroundColor(footerBackgroundColor).define { flex in
                flex.addItem(self.priceLabel)
                flex.addItem(self.distanceLabel).grow(1)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layout()
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        contentView.pin.width(size.width)
        self.layout()
        return contentView.frame.size
    }
    
    private func layout() {
        contentView.flex.layout(mode: .adjustHeight)
    }
    
    func configure(house: House) {
        self.nameLabel.text = house.name
        self.nameLabel.flex.markDirty()
        
        self.mainImage.download(url: house.mainImageURL)
        
        self.priceLabel.text = house.price
        self.priceLabel.flex.markDirty()
        
        self.distanceLabel.text = "\(house.distance) KM"
        self.distanceLabel.flex.markDirty()
        
        setNeedsLayout()
    }
}

struct House {
    let name: String
    let price: String
    let distance: Int
    let mainImageURL: URL
}
