//
//  MainView.swift
//

import SwiftUI

struct MainView: View {
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

extension MainView {
    private enum Constants {
        static let HomeTabName = "Home"
        static let HomeTabIconName = "house"
        static let CameraTabName = "Камера"
        static let CameraTabIconName = "camera"
        static let SettingsTabName = "Настройки"
        static let SettingsTabIconName = "gearshape"
    }
}

#Preview {
    MainView()
}
