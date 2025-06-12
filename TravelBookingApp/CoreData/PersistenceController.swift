//
//  PersistenceController.swift
//  TravelBookingApp
//
//  Created by Paranjothi iOS MacBook Pro on 12/06/25.
//
import SwiftUI
import CoreData


struct PersistenceController {
  static let shared = PersistenceController()
  let container: NSPersistentContainer

  init(inMemory: Bool = false) {
    container = NSPersistentContainer(name: "Model")
    if inMemory {
      container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
    }
    container.loadPersistentStores { _, error in
      if let e = error { fatalError(e.localizedDescription) }
    }
  }
}
