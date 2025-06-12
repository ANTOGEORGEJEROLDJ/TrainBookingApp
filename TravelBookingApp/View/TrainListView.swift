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
        ScrollView{
            VStack(spacing:20){
            ForEach(trains) { t in
                VStack(alignment: .leading, spacing: 8) {
                    VStack(alignment: .leading) {
                        Text(t.name)
                            .font(.headline)
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
                    
                    HStack {
                        NavigationLink(destination: RouteMapView(train: t)) {
                            Text("View Route")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        
                        NavigationLink(destination: BookingFormView(train: t, distance: 0)) {
                            Text("Book Now")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.orange)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                }
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(15)
                .shadow(radius: 3)
                .padding(.vertical)
            }
            .listStyle(.plain)
            .navigationTitle("Available Trains")
        }
        .padding()
    }
    }
}
