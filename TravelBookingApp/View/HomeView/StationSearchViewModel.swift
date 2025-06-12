//
//  StationSearchViewModel.swift
//  TravelBookingApp
//
//  Created by Paranjothi iOS MacBook Pro on 12/06/25.
//

import Foundation
import SwiftUI

class StationSearchViewModel: ObservableObject {
    @Published var allTrains: [TrainModel] = [
        TrainModel(
            id: UUID(),
            name: "Chennai Express",
            source: StationModel(id: UUID(), name: "Chennai", coordinate: .init(latitude: 13.08, longitude: 80.27)),
            destination: StationModel(id: UUID(), name: "Delhi", coordinate: .init(latitude: 28.61, longitude: 77.20)),
            departure: Date(),
            arrival: Date().addingTimeInterval(3600 * 6),
            classes: ["Tier 1 AC", "Sleeper"],
            prices: ["Tier 1 AC": 1200, "Sleeper": 400]
        ),
        TrainModel(
            id: UUID(),
            name: "Tuticorin Superfast",
            source: StationModel(id: UUID(), name: "Chennai", coordinate: .init(latitude: 13.08, longitude: 80.27)),
            destination: StationModel(id: UUID(), name: "Tuticorin", coordinate: .init(latitude: 8.76, longitude: 78.13)),
            departure: Date(),
            arrival: Date().addingTimeInterval(3600 * 9),
            classes: ["Tier 2 AC", "Sleeper"],
            prices: ["Tier 2 AC": 950, "Sleeper": 350]
        )
    ]
    
    @Published var filteredTrains: [TrainModel] = []
    
    func searchTrains(from: String, to: String) {
        filteredTrains = allTrains.filter {
            $0.source.name.lowercased().contains(from.lowercased()) &&
            $0.destination.name.lowercased().contains(to.lowercased())
        }
    }
}
