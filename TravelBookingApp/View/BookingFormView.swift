//
//  BookingFormView.swift
//  TravelBookingApp
//
//  Created by Paranjothi iOS MacBook Pro on 12/06/25.
//

import SwiftUI
import CoreData

struct BookingFormView: View {
  @Environment(\.managedObjectContext) var ctx
  @Environment(\.dismiss) var dismiss
  let train: TrainModel
  let distance: Double

  @State private var selectedClass = ""
  @State private var passengerName = ""
  @State private var travelDate = Date()

  var body: some View {
    Form {
      Section("Train") {
        Text(train.name).font(.headline)
        Picker("Class", selection: $selectedClass) {
          ForEach(train.classes, id: \.self) { cls in
            Text(cls)
          }
        }
        TextField("Passenger Name", text: $passengerName)
        DatePicker("Travel Date", selection: $travelDate, displayedComponents: .date)
      }

      Section("Fare") {
        Text("₹\(fare, specifier: "%.2f")")
      }

      Button("Book Ticket") {
        saveTicket()
        dismiss()
      }
      .disabled(selectedClass.isEmpty || passengerName.isEmpty)
      .buttonStyle(.borderedProminent)
    }
    .navigationTitle("Book Ticket")
  }

  var fare: Double {
    train.prices[selectedClass] ?? (distance * 0.5)
  }

  func saveTicket() {
    let ticket = TicketEntity(context: ctx)
    ticket.id = UUID()
    ticket.trainName = train.name
    ticket.source = train.source.name
    ticket.destination = train.destination.name
    ticket.travelDate = travelDate
    ticket.seatClass = selectedClass
    ticket.fare = fare
    try? ctx.save()
  }
}
