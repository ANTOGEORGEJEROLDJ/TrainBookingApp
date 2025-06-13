//
//  StationSearchView.swift
//  TravelBookingApp
//
//  Created by Paranjothi iOS MacBook Pro on 12/06/25.
//

import SwiftUI

struct TicketCard: Identifiable {
    let id = UUID()
    let from: String
    let to: String
    let departure: String
    let arrival: String
    let price: String
}


struct TrainHomeView: View {
    @State private var src = ""
    @State private var dest = ""
    @State private var showingResults = false
    @State private var selectedTicket: TicketCard? = nil
    @State private var showBooking = false
    @StateObject var vm = StationSearchViewModel()

    let sampleTickets = [
        TicketCard(from: "Chennai", to: "Tuticorin", departure: "06:00 AM", arrival: "12:00 PM", price: "₹450"),
        TicketCard(from: "Madurai", to: "Chennai", departure: "08:00 AM", arrival: "02:00 PM", price: "₹500"),
        TicketCard(from: "Coimbatore", to: "Trichy", departure: "09:30 AM", arrival: "01:30 PM", price: "₹400")
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("HariTRAIN")
                                .font(.title)
                                .bold()
                            Text("Find cheap bus tickets")
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 55, height: 55)
                    }

                    VStack(spacing: 16) {
                        Text("Railway Ticket Booking")
                            .font(.title3)
                            .bold()

                        TextField("From", text: $src)
                            .padding()
                            .frame(width: 320, height: 50)
                            .background(Color.white)
                            .cornerRadius(12)
                            .shadow(radius: 3)

                        TextField("To", text: $dest)
                            .padding()
                            .frame(width: 320, height: 50)
                            .background(Color.white)
                            .cornerRadius(13)
                            .shadow(radius: 3)

                        NavigationLink(
                            destination: TrainListView(trains: vm.filteredTrains),
                            isActive: $showingResults
                        ) {
                            EmptyView()
                        }

                        Button("Search Trains") {
                            vm.searchTrains(from: src, to: dest)
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                showingResults = true
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(15)
                        .disabled(src.isEmpty || dest.isEmpty)
                        .shadow(radius: 5)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(15)
                    .shadow(radius: 3)

                    VStack(alignment: .leading) {
                        Text("Cheap bus tickets")
                            .font(.title3)
                            .bold()
                        Text("From Chennai to Tuticorin")
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)

                    ForEach(sampleTickets) { ticket in
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Text("\(ticket.from) ➝ \(ticket.to)")
                                    .font(.headline)
                                Spacer()
                                Text(ticket.price)
                                    .foregroundColor(.green)
                            }
                            Text("Departure: \(ticket.departure)")
                            Text("Arrival: \(ticket.arrival)")
                                .foregroundColor(.gray)

                            Button("Book Now") {
                                selectedTicket = ticket
                                showBooking = true
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.orange)
                            .foregroundColor(.white)
                            .cornerRadius(15)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(15)
                        .shadow(radius: 4)
                    }

                    // Hidden NavigationLink for Booking
                    NavigationLink(
                        destination: selectedTicket.map { TrainBookingFormViewFromTicket(ticket: $0) },
                        isActive: $showBooking
                    ) {
                        EmptyView()
                    }

                }
                .padding()
            }
        }
    }
}
