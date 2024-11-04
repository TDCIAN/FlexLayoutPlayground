//
//  MenuViewController.swift
//  FlexLayoutPlayground
//
//  Created by 김정민 on 11/3/24.
//

import UIKit

enum PageType: Int, CaseIterable {
    case intro
    case rayWenderlich
    
    var text: String {
        switch self {
        case .intro:
            return "Intro Example"
        case .rayWenderlich:
            return "Raywenderlich Tutorial"
        }
    }
    
    var viewController: UIViewController {
        switch self {
        case .intro:
            return IntroViewController(pageType: self)
        case .rayWenderlich:
            return RaywenderlichTutorialViewController(pageType: self)
        }
    }
}

final class MenuViewController: BaseViewController {
    fileprivate var mainView: MenuView {
        return self.view as! MenuView
    }
    
    override init() {
        super.init()
        title = "FlexLayout Examples"
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = MenuView()
        self.mainView.delegate = self
    }
}

extension MenuViewController: MenuViewDelegate {
    func didSelect(pageType: PageType) {
        navigationController?.pushViewController(pageType.viewController, animated: true)
    }
}
