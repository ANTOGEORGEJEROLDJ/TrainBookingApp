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

            .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
