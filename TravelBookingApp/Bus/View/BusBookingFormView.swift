//
//  BusBookingFormView.swift
//  TravelBookingApp
//
//  Created by Paranjothi iOS MacBook Pro on 13/06/25.
//

import SwiftUI
import CoreData

struct BusBookingFormView: View {
    @Environment(\.managedObjectContext) var ctx
    @Environment(\.dismiss) var dismiss

    let train: TrainModel
    let distance: Double

    @State private var selectedClass: String
    @State private var passengerName = ""
    @State private var travelDate = Date()

    @State private var showingTicket = false
    @State private var savedTicket: TicketEntity?

    init(train: TrainModel, distance: Double) {
        self.train = train
        self.distance = distance
        _selectedClass = State(initialValue: train.classes.first ?? "")
    }

    var body: some View {
        NavigationView {
            ZStack {
                // Background Gradient
                LinearGradient(
                    gradient: Gradient(colors: [.white.opacity(0.2), .white]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ).ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 30) {
                        Text("🚆 Book Your Ticket")
                            .font(.largeTitle)
                            .bold()
                            .padding(.top, 10)

                        ticketInfoCard
                        passengerInputCard
                        fareSummaryCard

                        NavigationLink(destination: ticketDestination, isActive: $showingTicket) {
                            EmptyView()
                        }
                    }
                    .padding()
                }
            }
        }
    }

    // MARK: - Cards

    var ticketInfoCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Train: \(train.name)")
                .font(.title3)
                .bold()

            Text("\(train.source.name) → \(train.destination.name)")
                .foregroundColor(.secondary)

            Divider()

            Text("Select Class")
                .font(.headline)

            Picker("Class", selection: $selectedClass) {
                ForEach(train.classes, id: \.self) {
                    Text($0).tag($0)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(20)
        .shadow(radius: 5)
    }

    var passengerInputCard: some View {
        VStack(spacing: 16) {
            TextField("Passenger Name", text: $passengerName)
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .shadow(radius: 2)

            DatePicker("📅 Travel Date", selection: $travelDate, displayedComponents: .date)
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .shadow(radius: 2)
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(20)
        .shadow(radius: 5)
    }

    var fareSummaryCard: some View {
        VStack(spacing: 16) {
            HStack {
                Text("💰 Fare:")
                    .font(.headline)
                Spacer()
                Text("₹\(fare, specifier: "%.2f")")
                    .bold()
                    .foregroundColor(.green)
            }

            Button(action: {
                saveTicket()
            }) {
                HStack {
                    Spacer()
                    Text("Book Ticket")
                        .fontWeight(.semibold)
                        .padding()
                    Spacer()
                }
            }
            .background(passengerName.isEmpty ? Color.gray : Color.orange)
            .foregroundColor(.white)
            .cornerRadius(12)
            .disabled(passengerName.isEmpty)
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(20)
        .shadow(radius: 5)
    }

    // MARK: - Destination

    @ViewBuilder
    var ticketDestination: some View {
        if let ticket = savedTicket {
            ShowingTicketView(ticket: ticket)
        } else {
            Text("No ticket available.")
        }
    }

    // MARK: - Computed Fare

    var fare: Double {
        if let price = train.prices[selectedClass] {
            return price
        } else if distance.isFinite {
            return distance * 0.5
        } else {
            return 100.0
        }
    }

    // MARK: - Save Ticket

    func saveTicket() {
        let ticket = TicketEntity(context: ctx)
        ticket.id = UUID()
        ticket.trainName = train.name
        ticket.source = train.source.name
        ticket.destination = train.destination.name
        ticket.travelDate = travelDate
        ticket.seatClass = selectedClass
        ticket.fare = fare
        ticket.passengerName = passengerName

        do {
            try ctx.save()
            savedTicket = ticket
            showingTicket = true
        } catch {
            print("❌ Error saving ticket: \(error.localizedDescription)")
        }
    }
}
