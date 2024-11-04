//
//  ExpandedTableView.swift
//  FlexLayoutPlayground
//
//  Created by 김정민 on 11/4/24.
//

import UIKit

/*
 TableView that the method sizeThatFits() returns the size of all its cells.
 Support only cells with fixed height
 */
final class ExpandedTableView: UITableView {
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let numberOfCells = numberOfRows(inSection: 0)
        let cellsHeight = delegate?.tableView?(self, heightForRowAt: IndexPath(row: 0, section: 0)) ?? 0
        return CGSize(
            width: size.width,
            height: CGFloat(numberOfCells) * cellsHeight
        )
    }
}
