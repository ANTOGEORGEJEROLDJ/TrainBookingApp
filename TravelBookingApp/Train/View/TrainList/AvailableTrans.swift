//
//  TrainListView.swift
//  TravelBookingApp
//
//  Created by Paranjothi iOS MacBook Pro on 12/06/25.
//

import SwiftUI
import MapKit

struct AvailableTrans: View {
    let trains: [TrainModel]

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(trains) { t in
                    NavigationLink(destination: TrainDetailView(train: t)) {
                        VStack(alignment: .leading, spacing: 12) {
                            Text(t.name)
                                .font(.title2)
                                .bold()
                                .overlay(
                                    LinearGradient(colors: [.orange, .red], startPoint: .topLeading, endPoint: .bottomTrailing)
                                        .mask(
                                            Text(t.name)
                                                .font(.title2)
                                                .bold()
                                        )
                                )

                            Text("\(t.source.name) → \(t.destination.name)")
                                .font(.subheadline)
                                .foregroundColor(.green)

                            let duration = t.arrival.timeIntervalSince(t.departure) / 3600
                            Text(String(format: "Dep: %@, Dur: %.1f h",
                                        t.departure.formatted(date: .omitted, time: .shortened),
                                        duration))
                            .font(.footnote)
                            .foregroundColor(.gray)
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(.ultraThinMaterial)
                        .cornerRadius(15)
                        .shadow(radius: 5)
                    }
                }
            }
            .padding()
        }
        .padding(.top, 20)
        .navigationTitle("Available trans")
    }


    // MARK: - Calculate Distance using MapKit
    func calculateDistance(from: CLLocationCoordinate2D, to: CLLocationCoordinate2D) -> Double {
        let sourceLocation = CLLocation(latitude: from.latitude, longitude: from.longitude)
        let destinationLocation = CLLocation(latitude: to.latitude, longitude: to.longitude)
        let distanceInMeters = sourceLocation.distance(from: destinationLocation)
        let distanceInKm = distanceInMeters / 1000.0
        return round(distanceInKm * 10) / 10 // Round to 1 decimal
    }
}
