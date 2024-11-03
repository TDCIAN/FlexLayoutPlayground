//
//  MenuView.swift
//  FlexLayoutPlayground
//
//  Created by 김정민 on 11/3/24.
//

import UIKit

protocol MenuViewDelegate: AnyObject {
    func didSelect(pageType: PageType)
}

final class MenuView: UIView {
    weak var delegate: MenuViewDelegate?
    
    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(
            UITableViewCell.self,
            forCellReuseIdentifier: cellIdentifier
        )
        tableView.tableFooterView = UIView()
        return tableView
    }()
    fileprivate let cellIdentifier = "MenuViewCell"
    
    init() {
        super.init(frame: .zero)

        addSubview(self.tableView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.tableView.pin.size(frame.size)
    }
    
}

extension MenuView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PageType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = PageType(rawValue: indexPath.row)?.text ?? "FlexLayout Example"
        cell.textLabel?.font = .systemFont(ofSize: 12)
        
        return cell
    }
}

extension MenuView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let pageType = PageType(rawValue: indexPath.row) {
            delegate?.didSelect(pageType: pageType)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
