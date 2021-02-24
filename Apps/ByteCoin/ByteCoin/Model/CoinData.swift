//
//  CoinData.swift
//  ByteCoin
//
//  Created by Александр on 24.02.2021.
//

import Foundation

struct CoinData: Decodable {
    let asset_id_base: String // e-currency name
    let asset_id_quote: String // currency name
    let rate: Double // currency value
}
