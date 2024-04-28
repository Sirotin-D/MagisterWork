//
//  IconButton.swift
//

import SwiftUI

struct IconButton: View {
    let systemName: String
    let color: Color
    let font: Font
    let isEnabled: Bool
    let performAction: () -> Void
    
    init(systemName: String, color: Color = .blue, font: Font = .title, enabled: Bool = true, action: @escaping () -> Void) {
        self.systemName = systemName
        self.color = color
        self.font = font
        self.isEnabled = enabled
        self.performAction = action
    }
    
    var body: some View {
        Button(action: performAction) {
            Image(systemName: systemName)
                .foregroundColor( isEnabled ? color : .gray)
                .font(font)
        }
        .disabled(!isEnabled)
    }
}

#Preview {
    IconButton(systemName: "camera") {}
}
