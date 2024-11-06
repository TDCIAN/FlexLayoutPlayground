//
//  RaywenderlichTutorialViewController.swift
//  FlexLayoutPlayground
//
//  Created by 김정민 on 11/4/24.
//

import UIKit

final class RaywenderlichTutorialViewController: BaseViewController {
    fileprivate var mainView: RaywenderlichTutorialView {
        return self.view as! RaywenderlichTutorialView
    }
    
    init(pageType: PageType) {
        super.init()
        self.title = pageType.text
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func loadView() {
        let shows = self.loadShows()
        let series = Series(shows: shows)
        self.view = RaywenderlichTutorialView(series: series)
    }
    
    fileprivate func loadShows() -> [Show] {
        let path = Bundle.main.path(forResource: "Shows", ofType: "plist") ?? ""
        let dictArray = NSArray(contentsOfFile: path) as? [[String: AnyObject]]

        guard let path = Bundle.main.path(forResource: "Shows", ofType: "plist"),
              let dictArray = NSArray(contentsOfFile: path) as? [[String: AnyObject]]
        else { return [] }
        
        var shows: [Show] = []
        dictArray.forEach { (dict: [String : AnyObject]) in
            guard let title = dict["title"] as? String,
                  let length = dict["length"] as? String,
                  let details = dict["detail"] as? String,
                  let image = dict["image"] as? String
            else { fatalError("### loadShows() - Error parsing dict: \(dict)") }
            
            let show = Show(title: title, length: length, detail: details, image: image)
            shows.append(show)
        }
        
        return shows
    }
}
