//
//  IntroViewController.swift
//  FlexLayoutPlayground
//
//  Created by 김정민 on 11/3/24.
//

import UIKit

final class IntroViewController: BaseViewController {
    
    fileprivate var mainView: IntroView {
        return self.view as! IntroView
    }
    
    init(pageType: PageType) {
        super.init()
        title = pageType.text
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = IntroView()
    }
}
