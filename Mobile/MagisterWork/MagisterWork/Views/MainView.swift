//
//  MainView.swift
//

import SwiftUI

struct MainView: View {
    private enum Constants {
        static let HomeTabName = "Home"
        static let HomeTabIconName = "house"
        static let CameraTabName = "Камера"
        static let CameraTabIconName = "camera"
        static let SettingsTabName = "Настройки"
        static let SettingsTabIconName = "gearshape"
    }

    var body: some View {
        TabView {
            CameraView()
                .tabItem {
                    Label(Constants.CameraTabName, systemImage: Constants.CameraTabIconName)
                }
            SettingsView()
                .tabItem {
                    Label(Constants.SettingsTabName, systemImage: Constants.SettingsTabIconName)
                }
        }
    }
}

#Preview {
    MainView()
}
