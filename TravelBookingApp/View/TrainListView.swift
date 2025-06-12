//
//  TrainListView.swift
//  TravelBookingApp
//
//  Created by Paranjothi iOS MacBook Pro on 12/06/25.
//

import SwiftUI
import MapKit

struct TrainListView: View {
    let trains: [TrainModel]

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(trains) { t in
                    VStack(alignment: .leading, spacing: 12) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(t.name)
                                .font(.title2)
                                .bold()

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

                        HStack(spacing: 20) {
                            NavigationLink(destination: RouteMapView(train: t)) {
                                Label("Route", systemImage: "map.fill")
                                    .frame(width: 120, height: 40)
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(12)
                            }

                            NavigationLink(destination: BookingFormView(train: t, distance: calculateDistance(from: t.source.coordinate, to: t.destination.coordinate))) {
                                Label("Book Now", systemImage: "ticket.fill")
                                    .frame(width: 120, height: 40)
                                    .background(Color.orange)
                                    .foregroundColor(.white)
                                    .cornerRadius(12)
                            }
                        }
                        .padding(.top, 8)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.ultraThinMaterial)
                    .cornerRadius(15)
                    .shadow(radius: 4)
                }
            }
            .padding()
        }
        .navigationTitle("Available Trains")
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
