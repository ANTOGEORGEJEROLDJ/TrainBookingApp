//
//  TabVie.swift
//  TravelBookingApp
//
//  Created by Paranjothi iOS MacBook Pro on 13/06/25.
//

import SwiftUI

enum TravelMode {
    case bus
    case train
}

struct MainTabView: View {
    var selectedMode: TravelMode

    var body: some View {
        TabView {
            // Dynamic Home Tab
            Group {
                if selectedMode == .bus {
                    BusHomeView()
                        .tabItem {
                            Label("Home", systemImage: "bus.fill")
                        }
                } else {
                    TrainHomeView()
                        .tabItem {
                            Label("Home", systemImage: "train.side.front.car")
                        }
                }
            }

            // Common Tabs
            WalletView()
                .tabItem {
                    Label("Wallet", systemImage: "wallet.pass")
                }

            ProfileScreen()
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle")
                }
        }.navigationBarBackButtonHidden(true) // Hide default back button
    }
}
#Preview {
    MainTabView(selectedMode: .train)
}
