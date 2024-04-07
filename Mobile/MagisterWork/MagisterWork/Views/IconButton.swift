//
//  IconButton.swift
//

import SwiftUI

struct IconButton: View {
    let systemName: String
    let color: Color?
    let font: Font?
    let performAction: (() -> Void)?
    
    init(systemName: String, color: Color? = .blue, font: Font? = .title, action: (() -> Void)? = nil) {
        self.systemName = systemName
        self.color = color
        self.font = font
        self.performAction = action
    }
    
    var body: some View {
        Button(action: {
            performAction?()
        }) {
            Image(systemName: systemName)
                .foregroundColor(color)
                .font(font)
        }
    }
}

#Preview {
    IconButton(systemName: "camera")
}
