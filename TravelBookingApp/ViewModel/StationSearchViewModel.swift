//
//  StationSearchViewModel.swift
//  TravelBookingApp
//
//  Created by Paranjothi iOS MacBook Pro on 12/06/25.
//

import Foundation
import CoreLocation

class StationSearchViewModel: ObservableObject {
  @Published var allTrains: [TrainModel] = []
  @Published var filteredTrains: [TrainModel] = []

  init() {
    populateDummyTrains()
  }

  func populateDummyTrains() {
    let st1 = StationModel(id: UUID(), name: "Ooty", coordinate: CLLocationCoordinate2D(latitude: 11.0168, longitude: 76.9558))
    let st2 = StationModel(id: UUID(), name: "Chennai", coordinate: CLLocationCoordinate2D(latitude: 13.0827, longitude: 80.2707))
    let t1 = TrainModel(
      id: UUID(),
      name: "IR Chennai Express",
      source: st1,
      destination: st2,
      departure: Calendar.current.date(byAdding: .hour, value: 3, to: Date())!,
      arrival: Calendar.current.date(byAdding: .hour, value: 9, to: Date())!,
      classes: ["Sleeper", "3A", "2A", "1A"],
      prices: ["Sleeper": 400, "3A": 800, "2A": 1200, "1A": 2000]
    )
    allTrains = [t1]
  }

  func searchTrains(from: String, to: String) {
    filteredTrains = allTrains.filter {
      $0.source.name.localizedCaseInsensitiveContains(from) &&
      $0.destination.name.localizedCaseInsensitiveContains(to)
    }
  }
}
