//
//  BookingFormViewFromTicket.swift
//  TravelBookingApp
//
//  Created by Paranjothi iOS MacBook Pro on 12/06/25.
//

import SwiftUI

struct TrainBookingFormViewFromTicket: View {
    let ticket: TicketCard
    

    @State private var passengerName = ""
    @State private var seatClass = "Sleeper"
    let seatClasses = ["Sleeper", "AC", "First Class"]

    var body: some View {
        Form {
            Section(header: Text("Train Info")) {
                Text("From: \(ticket.from)")
                Text("To: \(ticket.to)")
                Text("Departure: \(ticket.departure)")
                Text("Arrival: \(ticket.arrival)")
                Text("Price: \(ticket.price)")
            }

            Section(header: Text("Passenger")) {
                TextField("Passenger Name", text: $passengerName)
                Picker("Seat Class", selection: $seatClass) {
                    ForEach(seatClasses, id: \.self) {
                        Text($0)
                    }
                }
            }

            Section {
                Button("Confirm Booking") {
                    // You can later add Core Data save logic here
                    print("Booking confirmed for \(passengerName) on \(ticket.from) ➝ \(ticket.to)")
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
        }
        .navigationTitle("Book Ticket")
    }
}
