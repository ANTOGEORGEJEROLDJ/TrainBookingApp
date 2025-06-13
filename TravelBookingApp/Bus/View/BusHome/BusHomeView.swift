//
//  BusHomeView.swift
//  TravelBookingApp
//
//  Created by Paranjothi iOS MacBook Pro on 13/06/25.
//

import SwiftUI

struct BusTicketCard: Identifiable {
    let id = UUID()
    let from: String
    let to: String
    let departure: String
    let arrival: String
    let price: String
}


struct BusHomeView: View {
    @State private var src = ""
    @State private var dest = ""
    @State private var showingResults = false
    @State private var selectedTicket: BusTicketCard? = nil
    @State private var showBooking = false
    @StateObject var vm = BusStandSearchViewModel()

    let sampleTickets = [
        BusTicketCard(from: "Chennai", to: "Tuticorin", departure: "06:00 AM", arrival: "12:00 PM", price: "₹450"),
        BusTicketCard(from: "Madurai", to: "Chennai", departure: "08:00 AM", arrival: "02:00 PM", price: "₹500"),
        BusTicketCard(from: "Coimbatore", to: "Trichy", departure: "09:30 AM", arrival: "01:30 PM", price: "₹400")
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // Header
                    HStack {
                        VStack(alignment: .leading) {
                            Text("HariBUS")
                                .font(.largeTitle).bold()
                            Text("Find cheap bus tickets")
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        Image(systemName: "person.crop.circle.fill")
                            .font(.system(size: 44))
                            .foregroundColor(.red)
                    }

                    // Search Form
                    VStack(spacing: 12) {
                        HStack {
                            Image(systemName: "location.fill")
                            TextField("From", text: $src)
                        }
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(8)
                        .shadow(radius: 3)

                        HStack {
                            Image(systemName: "location.fill")
                            TextField("To", text: $dest)
                        }
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(8)
                        .shadow(radius: 3)
                        
                        NavigationLink(
                            destination: AvailableTrans(trains: vm.filteredTrains),
                            isActive: $showingResults
                        ) {
                            EmptyView()
                        }
                        
                        Button("Search Buses") {
                            vm.searchTrains(from: src, to: dest)
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                showingResults = true
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .disabled(src.isEmpty || dest.isEmpty)
                    }
                    .cardStyle()
                    .shadow(radius: 3)

                    // Ticket List
                    Text("Available Buses")
                        .font(.title3)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)

                    ForEach(sampleTickets) { ticket in
                        BusTicketRow(ticket: ticket) {
                            selectedTicket = ticket
                            showBooking = true
                        }
                        .cardStyle()
                    }

                    NavigationLink("", destination: selectedTicket.map {
                        BusBookingFormViewFromTicket(Busticket: $0)
                    }, isActive: $showBooking)
                    .hidden()
                }
                .padding()
            }
        }
    }
}
extension View {
    func cardStyle() -> some View {
        self
            .padding()
            .background(Color.white)
            .cornerRadius(15)
            .shadow(color: Color.black.opacity(0.4), radius: 4, x: 3, y: 3)
    }
}

extension Color {
    static let themeRed = Color("red") // Define in Assets
    static let themeGray = Color("gray")
}
