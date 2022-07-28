//
//  Date+Utils.swift
//  CoSport
//
//  Created by Seyfülmülük Kutluk on 24.07.2022.
//

import Foundation

extension Date {
    static var bankeyDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "DMT")
        return formatter
    }
    
    var monthDayYearString: String {
        let dateFormatter = Date
    }
}
