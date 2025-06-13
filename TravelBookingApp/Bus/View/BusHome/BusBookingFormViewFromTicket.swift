//
//  BusBookingFormViewFromTicket.swift
//  TravelBookingApp
//
//  Created by Paranjothi iOS MacBook Pro on 13/06/25.
//

import SwiftUI

struct BusBookingFormViewFromTicket: View {
    let Busticket: BusTicketCard

    @State private var passengerName = ""
    @State private var seatClass = "Sleeper"
    
    let seatClasses = ["Sleeper", "AC", "First Class"]
    
    var body: some View {
        Form {
            Section(header: Text("Journey Details")) {
                Text("From: \(Busticket.from)")
                Text("To: \(Busticket.to)")
                Text("Departure: \(Busticket.departure)")
                Text("Arrival: \(Busticket.arrival)")
                Text("Price: \(Busticket.price)")
            }
            
            Section(header: Text("Passenger Info")) {
                TextField("Name", text: $passengerName)
                Picker("Seat Class", selection: $seatClass) {
                    ForEach(seatClasses, id: \.self) { Text($0) }
                }
            }
            Section {
                Button("Confirm Booking") {
                    print("Booked \(passengerName)")
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
        }
        .navigationTitle("Book Ticket")
    }
}
