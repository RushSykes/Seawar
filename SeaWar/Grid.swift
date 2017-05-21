//
//  Grid.swift
//  SeaWar
//
//  Created by Rush Sykes on 24/04/2017.
//  Copyright © 2017 RS. All rights reserved.
//

import Foundation

class Grid {
    // Definition of one column
    var columns: [GridColumn] = [GridColumn]()
    var columnCount = Singleton.gameInstance.size
    
    // Fill each column with ten rows
    init() {
        for _ in 0..<columnCount {
            columns.append(GridColumn())
        }
    }
    
    func getStatusFromCoord(col: Int, row: Int) ->GridStatus {
        return columns[col].getStatusFromRow(index: row)
    }
    
    func setStatusToCoord(col: Int, row: Int, status: GridStatus) {
        columns[col].setStatusToRow(index: row, status: status)
    }
}
