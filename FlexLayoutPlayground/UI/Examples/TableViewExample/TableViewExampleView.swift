//
//  TableViewExampleView.swift
//  FlexLayoutPlayground
//
//  Created by 김정민 on 11/6/24.
//

import UIKit

final class TableViewExampleView: UIView {
    
    private let tableView = UITableView()
    private let methodCellTamplate = MethodCell()
    
    private var methods: [Method] = []
    
    init() {
        super.init(frame: .zero)
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.tableFooterView = UIView()
        self.tableView.estimatedRowHeight = 10
        self.tableView.register(MethodCell.self, forCellReuseIdentifier: MethodCell.className)
        self.tableView.register(MethodGroupHeader.self, forHeaderFooterViewReuseIdentifier: MethodGroupHeader.className)
        addSubview(self.tableView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.tableView.pin.all()
    }
    
    func configure(method: [Method]) {
        self.methods = method
        self.tableView.reloadData()
    }
}

// MARK: UITableViewDataSource
extension TableViewExampleView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.methods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: MethodCell.className,
            for: indexPath
        ) as! MethodCell
        
        let method = self.methods[indexPath.row]
        cell.configure(method: method)
        
        return cell
    }
}

// MARK: UITableViewDelegate
extension TableViewExampleView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return MethodGroupHeader.height
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: MethodGroupHeader.className) as! MethodGroupHeader
        header.configure(title: "Flex container methods")
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // The UITableView will call the cell's sizeThatFit() method to compute the height.
        // WARNING: You must also set the UITableView.estimatedRowHeight for this to work.
        return UITableView.automaticDimension
    }
}
