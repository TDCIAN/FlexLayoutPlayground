//
//  YogaExampleCViewController.swift
//  FlexLayoutPlayground
//
//  Created by 김정민 on 11/14/24.
//

import UIKit

final class YogaExampleCViewController: UIViewController {
    
    init(pageType: PageType) {
        super.init(nibName: nil, bundle: nil)
        self.title = pageType.text
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = YogaExampleCView()
    }
}
