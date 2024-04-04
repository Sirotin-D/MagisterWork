//
//  MainView.swift
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label(Constants.HomeTabName, systemImage: Constants.HomeTabIconName)
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
        static let HomeTabName = "Классификатор"
        static let HomeTabIconName = "house"
        static let SettingsTabName = "Настройки"
        static let SettingsTabIconName = "gearshape"
    }
}

#Preview {
    MainView()
}
