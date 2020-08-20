//
//  CoinData.swift
//  ByteCoin
//
//  Created by Jesus Lopez on 8/13/20.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import Foundation

struct CoinData: Decodable {
    let rate: Double
    let asset_id_quote: String
}
