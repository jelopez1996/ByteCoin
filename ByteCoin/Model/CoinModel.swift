//
//  CoinModel.swift
//  ByteCoin
//
//  Created by Jesus Lopez on 8/13/20.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import Foundation

struct CoinModel {
    let rate: Double
    let country: String
    var formatedRate: String {
        return String(format: "%.2f", rate)
    }
}
