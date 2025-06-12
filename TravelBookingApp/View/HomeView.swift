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

struct HomeView: View {
    @State private var src = ""
    @State private var dest = ""
    @State private var showingResults = false
    @StateObject var vm = StationSearchViewModel()
    
    let sampleTickets = [
        TicketCard(from: "Chennai", to: "Tuticorin", departure: "06:00 AM", arrival: "12:00 PM", price: "₹450"),
        TicketCard(from: "Madurai", to: "Chennai", departure: "08:00 AM", arrival: "02:00 PM", price: "₹500"),
        TicketCard(from: "Coimbatore", to: "Trichy", departure: "09:30 AM", arrival: "01:30 PM", price: "₹400")
    ]
    
    var body: some View {
            ScrollView {
                VStack(spacing: 20) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("HariBUS")
                                .font(.title)
                                .bold()
                            Text("Find cheap bus tickets")
                                .font(.subheadline)
                                .foregroundColor(.black.opacity(0.5))
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
                        
                        TextField("Source station", text: $src)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(15)
                            .shadow(radius: 3)
                        
                        TextField("Destination station", text: $dest)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(15)
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
                    .shadow(radius: 5)
                    
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
                            Button("Book Now") {}
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
                }
                .padding()
            }
        
    }
}
