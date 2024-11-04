//
//  RaywenderlichTutorialView.swift
//  FlexLayoutPlayground
//
//  Created by 김정민 on 11/4/24.
//

import UIKit
import FlexLayout
import PinLayout

final class RaywenderlichTutorialView: UIView {
    fileprivate let contentView = UIScrollView()
    fileprivate let rootFlexContainer = UIView()
    fileprivate let showSelectedIndex = 0
    
    fileprivate let series: Series
    
    let episodeImageView = UIImageView()
    let summaryPopularityLabel = UILabel()
    let episodeTitleLabel = UILabel()
    let descriptionLabel = UILabel()
    let showsTableView = ExpandedTableView()
    
    init(series: Series) {
        self.series = series
        
        super.init(frame: .zero)
        
        backgroundColor = .black
        
        let padding: CGFloat = 8
        let paddingHorizontal: CGFloat = 8.0
        
        // Popularity
        self.summaryPopularityLabel.text = String(repeating: "*", count: series.showPopularity)
        self.summaryPopularityLabel.textColor = .red
        
        // Year
        let yearLabel = UILabel()
        yearLabel.text = series.showYear
        yearLabel.textColor = .lightGray
        
        // Rating
        let ratingLabel = UILabel()
        ratingLabel.text = series.showRating
        ratingLabel.textColor = .lightGray
        
        // Length
        let lengthLabel = UILabel()
        lengthLabel.text = series.showLength
        lengthLabel.textColor = .lightGray
        
        // Episode Id
        let episodeIdLabel = self.showLabelFor(text: series.selectedShow, font: .boldSystemFont(ofSize: 16.0))
        
        // Episode Title
        self.initLabelFor(self.episodeTitleLabel, font: .boldSystemFont(ofSize: 16.0))
        
        // Description
        self.initLabelFor(self.descriptionLabel, font: .systemFont(ofSize: 14.0))
        self.descriptionLabel.numberOfLines = 3
        
        // Cast & creators
        let castLabel = self.showLabelFor(text: "Cast: \(series.showCast)", font: .boldSystemFont(ofSize: 14.0))
        let creatorsLabel = self.showLabelFor(text: "Creators: \(series.showCreators)", font: .boldSystemFont(ofSize: 14.0))
        
        // Action views
        let addActionView = self.showActionViewFor(imageName: "add", text: "My List")
        let shareActionView = self.showActionViewFor(imageName: "share", text: "Share")
        
        // Tabs
        let episodesTabView = self.showTabBarFor(text: "EPISODES", selected: true)
        let moreTabView = self.showTabBarFor(text: "MORE LIKE THIS", selected: false)
        
        self.showsTableView.delegate = self
        self.showsTableView.dataSource = self
        self.showsTableView.backgroundColor = self.backgroundColor
        self.showsTableView.register(
            ShowTableViewCell.self,
            forCellReuseIdentifier: ShowTableViewCell.className
        )
        
        self.rootFlexContainer.flex.define { flex in
            // Image
            flex.addItem(self.episodeImageView).grow(1).backgroundColor(.gray)
            
            // Summary row
            flex.addItem().direction(.row).padding(padding).define { flex in
                flex.addItem(self.summaryPopularityLabel).grow(1)
                
                flex.addItem().direction(.row).justifyContent(.spaceBetween).grow(2).define { flex in
                    flex.addItem(yearLabel)
                    flex.addItem(ratingLabel)
                    flex.addItem(lengthLabel)
                }
                
                flex.addItem().width(100).height(1).grow(1)
            }
            
            // Title row
            flex.addItem().direction(.row).padding(padding).define { flex in
                flex.addItem(episodeIdLabel)
                flex.addItem(self.episodeTitleLabel).marginLeft(20)
            }
            
            // Description section
            flex.addItem().paddingHorizontal(paddingHorizontal).define { flex in
                flex.addItem(self.descriptionLabel)
                flex.addItem(castLabel)
                flex.addItem(creatorsLabel)
            }
            
            // Action row
            flex.addItem().direction(.row).padding(padding).define { flex in
                flex.addItem(addActionView)
                flex.addItem(shareActionView)
            }
            
            // Tabs row
            flex.addItem().direction(.row).padding(padding).define { flex in
                flex.addItem(episodesTabView)
                flex.addItem(moreTabView)
            }
            
            // Shows TableView
            flex.addItem(self.showsTableView).grow(1)
        }
        
        self.contentView.addSubview(self.rootFlexContainer)
        
        addSubview(contentView)
        
        // Show the first episode
        self.didSelectShow(show: series.shows[0])
        self.showsTableView.selectRow(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .top)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 1) Layout the contentView & rootFlexContainer using PinLayout
        self.contentView.pin.all(pin.safeArea)
        self.rootFlexContainer.pin.top().left().right()
        
        // 2) Let the flexbox container layout itself and adjust the height
        self.rootFlexContainer.flex.layout(mode: .adjustHeight)
        
        // 3) Adjust the scrollview contentSize
        self.contentView.contentSize = self.rootFlexContainer.frame.size
    }
    
    fileprivate func didSelectShow(show: Show) {
        // Episode Image
        let image = UIImage(named: show.image)
        let imageAspectRatio = (image?.size.width ?? 1.0) / (image?.size.height ?? 1.0)
        self.episodeImageView.image = image
        self.episodeImageView.flex.aspectRatio(imageAspectRatio).markDirty()
        
        self.episodeTitleLabel.text = show.title
        self.episodeTitleLabel.flex.markDirty()
        
        self.descriptionLabel.text = show.detail
        self.descriptionLabel.flex.markDirty()
        
        // Force a re layout
        setNeedsLayout()
    }
    
    fileprivate func showLabelFor(text: String?, font: UIFont = .systemFont(ofSize: 14)) -> UILabel {
        let label = UILabel(frame: .zero)
        self.initLabelFor(label, text: text, font: font)
        return label
    }
    
    fileprivate func initLabelFor(_ label: UILabel, text: String? = nil, font: UIFont = .systemFont(ofSize: 14)) {
        label.font = font
        label.textColor = .lightGray
        label.text = text
        label.flex.marginBottom(5)
    }
    
    fileprivate func showActionViewFor(imageName: String, text: String) -> UIView {
        let actionView = UIView()
        
        actionView.flex.alignItems(.center).width(50).marginRight(20.0).define { flex in
            let actionButton = UIButton(type: .custom)
            actionButton.setImage(UIImage(named: imageName), for: .normal)
            flex.addItem(actionButton).padding(10)
            
            let actionLabel = self.showLabelFor(text: text)
            flex.addItem(actionLabel)
        }
        
        return actionView
    }
    
    fileprivate func showTabBarFor(text: String, selected: Bool) -> UIView {
        let tabLabelFont = selected ? UIFont.boldSystemFont(ofSize: 14.0) : UIFont.systemFont(ofSize: 14.0)
        
        let labelSize = text.size(withAttributes: [NSAttributedString.Key.font: tabLabelFont])
        
        let tabView = UIView()
        
        tabView.flex.alignItems(.center).marginRight(20).define { flex in
            let tabSelectionView = UIView()
            flex.addItem(tabSelectionView).width(labelSize.width).height(3).marginBottom(5).backgroundColor(selected ? .red : .clear)
            
            let tabLabel = self.showLabelFor(text: text, font: tabLabelFont)
            flex.addItem(tabLabel)
        }
        
        return tabView
    }
}

extension RaywenderlichTutorialView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.series.shows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: ShowTableViewCell.className,
            for: indexPath
        ) as! ShowTableViewCell
        cell.configure(show: self.series.shows[indexPath.row])
        return cell
    }
}

extension RaywenderlichTutorialView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.didSelectShow(show: self.series.shows[indexPath.row])
    }
}
