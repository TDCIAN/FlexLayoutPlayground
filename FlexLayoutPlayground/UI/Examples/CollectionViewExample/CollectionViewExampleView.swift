//
//  CollectionViewExampleView.swift
//  FlexLayoutPlayground
//
//  Created by 김정민 on 11/8/24.
//

import UIKit

final class CollectionViewExampleView: UIView {
    
    private let collectionView: UICollectionView
    private let flowLayout = UICollectionViewFlowLayout()
    private let cellTemplate = HouseCell()
    
    private var houses: [House] = []
    
    init() {
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.flowLayout)
        
        super.init(frame: .zero)
        
        self.flowLayout.minimumLineSpacing = 8
        self.flowLayout.minimumInteritemSpacing = 0
        
        self.flowLayout.sectionInsetReference = .fromSafeArea
        
        self.collectionView.backgroundColor = .white
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(
            HouseCell.self,
            forCellWithReuseIdentifier: HouseCell.className
        )
        self.addSubview(self.collectionView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.collectionView.pin.vertically().horizontally(pin.safeArea)
    }
    
    func configure(houses: [House]) {
        self.houses = houses
        self.collectionView.reloadData()
    }
    
    func viewOrientationDidChange() {
        self.flowLayout.invalidateLayout()
    }
}

extension CollectionViewExampleView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.houses.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: HouseCell.className,
            for: indexPath
        ) as! HouseCell
        cell.configure(house: self.houses[indexPath.row])
        return cell
    }
}

extension CollectionViewExampleView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        self.cellTemplate.configure(house: self.houses[indexPath.row])
        return self.cellTemplate.sizeThatFits(CGSize(width: collectionView.bounds.width, height: .greatestFiniteMagnitude))
    }
}
