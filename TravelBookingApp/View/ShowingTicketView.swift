//
//  ShowingTicketView.swift
//  TravelBookingApp
//
//  Created by Paranjothi iOS MacBook Pro on 12/06/25.
//

import SwiftUI
import CoreData

struct ShowingTicketView: View {
    let ticket: TicketEntity

    var body: some View {
        VStack(spacing: 20) {
            Text("🎫 Your Ticket")
                .font(.largeTitle)
                .bold()

            VStack(alignment: .leading, spacing: 10) {
                Text("Train: \(ticket.trainName ?? "N/A")")
                Text("From: \(ticket.source ?? "N/A")")
                Text("To: \(ticket.destination ?? "N/A")")
                if let date = ticket.travelDate {
                    Text("Date: \(date, formatter: dateFormatter)")
                }
                Text("Class: \(ticket.seatClass ?? "N/A")")
                Text("Passenger: \(ticket.passengerName ?? "N/A")")
                Text("Fare: ₹\(ticket.fare, specifier: "%.2f")")
                    .bold()
            }
            .padding()
            .frame(width: 300, height: 500)
            .background(Color.orange.opacity(0.2))
            .cornerRadius(12)

            Spacer()
        }
        .padding()
    }

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
}
