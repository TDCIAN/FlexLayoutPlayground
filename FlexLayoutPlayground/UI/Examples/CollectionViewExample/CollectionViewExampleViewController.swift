//
//  CollectionViewExampleViewController.swift
//  FlexLayoutPlayground
//
//  Created by 김정민 on 11/8/24.
//

import UIKit

final class CollectionViewExampleViewController: BaseViewController {
    
    private var mainView: CollectionViewExampleView {
        return self.view as! CollectionViewExampleView
    }
    
    init(pageType: PageType) {
        super.init()
        
        title = pageType.text
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = CollectionViewExampleView()
        self.mainView.configure(houses: [
            House(name: "Castlecrag House",
                  price: "1,500,000$",
                  distance: 12,
                  mainImageURL: URL(string: "https://i.pinimg.com/736x/76/cc/b4/76ccb45bc61b098c7b9b75de62fcf533--house-design-campo-grande.jpg")!),
            House(name: "Port Ludlow House",
                  price: "1,240,000$",
                  distance: 15,
                  mainImageURL: URL(string: "https://st.hzcdn.com/simgs/f271957f001074d1_4-3434/modern-exterior.jpg")!),
            House(name: "Modern Facade boxes House",
                  price: "950,000$",
                  distance: 22,
                  mainImageURL: URL(string: "https://i.pinimg.com/originals/10/b2/cd/10b2cdbf28cef49281463998dda20796.jpg")!),
            House(name: "Contemporary Modern Home",
                  price: "1,456,000$",
                  distance: 32,
                  mainImageURL: URL(string: "https://i.pinimg.com/736x/5e/8f/0b/5e8f0b24f19624754d2aa37968217d5d--architecture-house-design-modern-house-design.jpg")!),
            House(name: "Angel House",
                  price: "932,000$",
                  distance: 82,
                  mainImageURL: URL(string: "https://i.pinimg.com/736x/6d/6c/ab/6d6cab9db70117727e3eb2adf0dbc080--small-modern-house-plans-modern-houses.jpg")!)
        ])
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: any UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        self.mainView.viewOrientationDidChange()
    }
}
