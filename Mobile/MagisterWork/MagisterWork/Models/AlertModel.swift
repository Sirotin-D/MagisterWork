//
//  AlertModel.swift
//

import SwiftUI

struct AlertModel {
    var title: LocalizedStringKey = ""
    var message: LocalizedStringKey = ""
    var isActionButtonEnabled = false
    var actionButtonTitle: LocalizedStringKey = ""
    var actionButtonHandler: (() -> Void)? = nil
}
