//
//  String+localized.swift
//

import Foundation

extension String {
    var localized: String {
        return String(localized: String.LocalizationValue(self))
    }
}
