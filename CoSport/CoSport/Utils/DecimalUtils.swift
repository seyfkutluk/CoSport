//
//  DecimalUtils.swift
//  CoSport
//
//  Created by Seyfülmülük Kutluk on 11.07.2022.
//

import Foundation

extension Decimal {
    var doubleValue: Double {
        return NSDecimalNumber(decimal: self).doubleValue
    }
}
