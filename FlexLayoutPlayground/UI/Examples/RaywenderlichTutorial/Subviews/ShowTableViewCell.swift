//
//  ShowTableViewCell.swift
//  FlexLayoutPlayground
//
//  Created by 김정민 on 11/4/24.
//

import UIKit

final class ShowTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        self.textLabel?.textColor = .white
        self.textLabel?.font = .systemFont(ofSize: 14.0)
        self.textLabel?.numberOfLines = 2
        self.textLabel?.adjustsFontSizeToFitWidth = true
        self.textLabel?.minimumScaleFactor = 0.8
        self.detailTextLabel?.textColor = .lightGray
        
        let accessoryView = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        accessoryView.image = UIImage(named: "download")
        self.accessoryView = accessoryView
        
        self.backgroundColor = .clear
        self.separatorInset = .zero
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(show: Show) {
        self.textLabel?.text = show.title
        self.detailTextLabel?.text = show.length
        self.imageView?.image = UIImage(named: show.image)
    }
}
