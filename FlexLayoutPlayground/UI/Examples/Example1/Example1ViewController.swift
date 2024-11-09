//
//  Example1ViewController.swift
//  FlexLayoutPlayground
//
//  Created by 김정민 on 11/9/24.
//

import UIKit

final class Example1ViewController: UIViewController {
    
    init(pageType: PageType) {
        super.init(nibName: nil, bundle: nil)
        self.title = pageType.text
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = Example1View()
    }
}
