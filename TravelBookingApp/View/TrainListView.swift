//
//  TrainListView.swift
//  TravelBookingApp
//
//  Created by Paranjothi iOS MacBook Pro on 12/06/25.
//

import SwiftUI

struct TrainListView: View {
  let trains: [TrainModel]

  var body: some View {
    List(trains) { t in
      NavigationLink(destination: RouteMapView(train: t)) {
        VStack(alignment: .leading) {
          Text(t.name).font(.headline)
          Text("\(t.source.name) → \(t.destination.name)")
          let duration = t.arrival.timeIntervalSince(t.departure)/3600
          Text(String(format: "Dep: %@, Dur: %.1f h", t.departure.formatted(date: .omitted, time: .shortened), duration))
        }
        .padding(.vertical, 8)
      }
    }
    .navigationTitle("Available Trains")
  }
}
