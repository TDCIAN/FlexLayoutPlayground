//
//  IntroViewController.swift
//  FlexLayoutPlayground
//
//  Created by 김정민 on 11/3/24.
//

import UIKit

final class IntroViewController: UIViewController {
    
    init(pageType: PageType) {
        super.init(nibName: nil, bundle: nil)
        title = pageType.text
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = IntroView()
    }
}
