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
            ScrollView {
                VStack(spacing: 20) {
                    Text("Book Ticket")
                        .font(.largeTitle)
                        .bold()

                    trainAndClassSection
                    passengerNameField
                    travelDatePicker
                    fareAndBookButtonSection

                    NavigationLink(destination: ticketDestination, isActive: $showingTicket) {
                        EmptyView()
                    }
                }
                .padding()
            }
            .background(LinearGradient(gradient: Gradient(colors: [.orange.opacity(0.15), .white]), startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea())
        }
    }

    // MARK: - Subviews

    var trainAndClassSection: some View {
        VStack(alignment: .leading) {
            Text("Train: \(train.name)")
                .font(.headline)

            Picker("Class", selection: $selectedClass) {
                ForEach(train.classes, id: \.self) { cls in
                    Text(cls)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
    }

    var passengerNameField: some View {
        TextField("Passenger Name", text: $passengerName)
            .padding()
            .background(Color.white)
            .cornerRadius(15)
    }

    var travelDatePicker: some View {
        DatePicker("Travel Date", selection: $travelDate, displayedComponents: .date)
            .padding()
            .background(Color.white)
            .cornerRadius(15)
    }

    var fareAndBookButtonSection: some View {
        VStack(spacing: 10) {
            Text("Fare: ₹\(fare, specifier: "%.2f")")
                .bold()

            Button("Book Ticket") {
                saveTicket()
            }
            .disabled(passengerName.isEmpty)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.orange)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
        .background(Color.white.opacity(0.9))
        .cornerRadius(15)
    }

    

    @ViewBuilder
    var ticketDestination: some View {
        if let ticket = savedTicket {
            ShowingTicketView(ticket: ticket)
        } else {
            Text("No ticket data available.")
        }
    }

    var fare: Double {
        if let price = train.prices[selectedClass] {
            return price
        } else if distance.isFinite {
            return distance * 0.5
        } else {
            return 100.0
        }
    }

    func saveTicket() {
        print("🚨 Distance: \(distance), Fare: \(fare), Selected Class: \(selectedClass)")

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
