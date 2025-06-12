//
//  TravelBookingAppApp.swift
//  TravelBookingApp
//
//  Created by Paranjothi iOS MacBook Pro on 12/06/25.
//

import SwiftUI

@main
struct TravelBookingAppApp: App {
    let persistence = PersistenceController.shared

      var body: some Scene {
        WindowGroup {
          NavigationStack {
            HomeView()
              .environment(\.managedObjectContext, persistence.container.viewContext)
          }
        }
      }
    }
