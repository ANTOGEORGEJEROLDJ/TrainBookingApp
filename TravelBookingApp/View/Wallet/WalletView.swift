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
    ) private var tickets: FetchedResults<TicketEntity>

    var body: some View {
        NavigationStack {
            ZStack {
                // Gradient background
                LinearGradient(
                    gradient: Gradient(colors: [.white.opacity(0.1), .white]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ).ignoresSafeArea()

                if tickets.isEmpty {
                    VStack {
                        Image(systemName: "ticket")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.orange)

                        Text("No Tickets Booked Yet")
                            .font(.title3)
                            .foregroundColor(.gray)
                    }
                } else {
                    List {
                        ForEach(tickets) { t in
                            TicketCardView(ticket: t)
                                .listRowBackground(Color.clear)
                                .listRowSeparator(.hidden)
                        }
                        .onDelete(perform: deleteTicket)
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationTitle("🎟️ Booked Tickets")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
        }
    }

    // MARK: - Delete Handler

    func deleteTicket(at offsets: IndexSet) {
        offsets.forEach { index in
            let ticket = tickets[index]
            ctx.delete(ticket)
        }
        try? ctx.save()
    }
}

// MARK: - Ticket Card View

struct TicketCardView: View {
    let ticket: TicketEntity

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(ticket.trainName ?? "Unknown Train")
                        .font(.headline)
                        .foregroundColor(.primary)

                    Text("\(ticket.source ?? "") → \(ticket.destination ?? "")")
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                    if let date = ticket.travelDate {
                        Text("📅 " + date.formatted(date: .abbreviated, time: .omitted))
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                }

                Spacer()

                VStack(alignment: .trailing) {
                    Text(ticket.seatClass ?? "Class")
                        .font(.subheadline)
                        .padding(6)
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(8)

                    Text("₹\(ticket.fare, specifier: "%.2f")")
                        .bold()
                        .foregroundColor(.green)
                }
            }
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(20)
        .shadow(radius: 3)
        .padding(.vertical, 4)
    }
}
