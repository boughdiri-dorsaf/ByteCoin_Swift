//
//  CoinModel.swift
//  ByteCoin
//
//  Created by Boughdiri Dorsaf on 15/12/2022.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import Foundation

struct CoinModel {
    let name: String
    let rate: Double
    
    var rateString: String {
        return String(format: "%.1f", rate)
    }
}
