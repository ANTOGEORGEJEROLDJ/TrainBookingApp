//
//  TabVie.swift
//  TravelBookingApp
//
//  Created by Paranjothi iOS MacBook Pro on 13/06/25.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
        
                        TrainHomeView()
                            .tabItem { Label("Home", systemImage: "house") }
                        WalletView()
                            .tabItem { Label("Wallet", systemImage: "wallet.pass") }
        
                        ProfileScreen()
                            .tabItem { Label("Profile", systemImage: "person.crop.circle") }
                    }
    }
}

#Preview {
    MainTabView()
}
