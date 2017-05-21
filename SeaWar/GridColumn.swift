//
//  GridColumn.swift
//  SeaWar
//
//  Created by Rush Sykes on 24/04/2017.
//  Copyright © 2017 RS. All rights reserved.
//

import Foundation

class GridColumn {
    
    // The game maintains the board as 10 rows in which there are 10 columns
    // Here's the definition of 10 rows in one column
    var rows: [GridStatus] = [];
    var rowCount: Int = Singleton.gameInstance.size
    
    init() {
        for _ in 0 ..< rowCount {
            rows.append(GridStatus.isWater)
        }
    }
    
    func getStatusFromRow(index: Int) -> GridStatus {
        return rows[index]
    }
    
    func setStatusToRow(index: Int, status: GridStatus) {
        rows[index] = status
    }
    
}
