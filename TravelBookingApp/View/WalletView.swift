//
//  WalletView.swift
//  TravelBookingApp
//
//  Created by Paranjothi iOS MacBook Pro on 12/06/25.
//

import SwiftUI
import CoreData

struct WalletView: View {
  @Environment(\.managedObjectContext) var ctx
  @FetchRequest(
    sortDescriptors: [NSSortDescriptor(keyPath: \TicketEntity.travelDate, ascending: true)],
    animation: .default
  )
  private var tickets: FetchedResults<TicketEntity>

  var body: some View {
    NavigationStack {
      List {
        ForEach(tickets) { t in
          VStack(alignment: .leading, spacing: 4) {
            Text("\(t.trainName ?? "") — \(t.seatClass ?? "")")
              .font(.headline)
            Text("\(t.source ?? "") → \(t.destination ?? "")")
            Text(t.travelDate!, formatter: dateFmt)
              .font(.subheadline)
            Text("Fare: ₹\(t.fare, specifier: "%.2f")")
              .bold()
          }
          .padding(.vertical, 8)
        }
        .onDelete { idxs in
          idxs.forEach {
            ctx.delete(tickets[$0])
          }
          try? ctx.save()
        }
      }
      .navigationTitle("Booked Tickets")
      .toolbar {
        EditButton()
      }
    }
  }
}

private let dateFmt: DateFormatter = {
  let f = DateFormatter()
  f.dateStyle = .medium
  return f
}()
