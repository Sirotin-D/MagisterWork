//
//  MainView.swift
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label(Constants.HomeTabName, systemImage: IconNames.HomeTabIconName)
                }
            SettingsView()
                .tabItem {
                    Label(Constants.SettingsTabName, systemImage: IconNames.SettingsTabIconName)
                }
        }
    }
}

extension MainView {
    private enum Constants {
        static let HomeTabName: LocalizedStringKey = "Classificator"
        static let SettingsTabName: LocalizedStringKey = "Settings"
    }
    
    private enum IconNames {
        static let HomeTabIconName = "house"
        static let SettingsTabIconName = "gearshape"
    }
}

#Preview {
    MainView()
}
