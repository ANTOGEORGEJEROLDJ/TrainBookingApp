//
//  TravelBookingAppApp.swift
//  TravelBookingApp
//
//  Created by Paranjothi iOS MacBook Pro on 12/06/25.
//

import SwiftUI

@main
struct TravelBookingApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            SelectingView()
//            TabView {
//                
//                TrainHomeView()
//                    .tabItem { Label("Home", systemImage: "house") }
//                WalletView()
//                    .tabItem { Label("Wallet", systemImage: "wallet.pass") }
//
//                ProfileScreen()
//                    .tabItem { Label("Profile", systemImage: "person.crop.circle") }
//            }
            .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
