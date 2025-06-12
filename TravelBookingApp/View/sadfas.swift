//
//  sadfas.swift
//  TravelBookingApp
//
//  Created by Paranjothi iOS MacBook Pro on 12/06/25.
//

import SwiftUI

struct TicketCards: Identifiable {
    let id = UUID()
    let from: String
    let to: String
    let departure: String
    let arrival: String
    let price: String
}

struct HomeViews: View {
    
    // Sample ticket data
    let sampleTickets = [
        TicketCard(from: "Chennai", to: "Tuticorin", departure: "06:00 AM", arrival: "12:00 PM", price: "₹450"),
        TicketCard(from: "Madurai", to: "Chennai", departure: "08:00 AM", arrival: "02:00 PM", price: "₹500"),
        TicketCard(from: "Coimbatore", to: "Trichy", departure: "09:30 AM", arrival: "01:30 PM", price: "₹400")
    ]
    
    @State private var src = ""
    @State private var dest = ""
    @State private var showingResults = false
    @StateObject var vm = StationSearchViewModel()
    
    var body: some View {
        ScrollView{
            VStack{
                HStack{
                    VStack(alignment: .leading){
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
                        .scaledToFit()
                        .frame(width: 55, height: 55)
                        .padding(.leading)
                }
                
                VStack(spacing: 16) {
                    Text("Railway Ticket Booking")
                            .font(.title3)
                            .bold()
                            .padding(.top,-10)
                    
                    TextField("Source station", text: $src)
                        .textFieldStyle(.plain)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.white.opacity(0.8))
                        .shadow(radius: 3)
                        .cornerRadius(15)
                        
                    TextField("Destination station", text: $dest)
                        .textFieldStyle(.plain)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.white.opacity(0.8))
                        .shadow(radius: 3)
                        .cornerRadius(15)
                    
                    // Hidden NavigationLink triggered by showingResults
                    NavigationLink(
                        destination: TrainListView(trains: vm.filteredTrains),
                        isActive: $showingResults
                    ) {
                        EmptyView()
                    }
                    // Your styled button
                    Button(action: {
                        vm.searchTrains(from: src, to: dest)
                        showingResults = true
                    }) {
                        Text("Search Trains")
                            .frame(width: 258, height: 22)
                            .padding()
                            .bold()
                            .background(Color.orange)
                            .foregroundColor(.white)
                            .font(.headline)
                            .cornerRadius(15)
                            .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 5)
                    }
                    .disabled(src.isEmpty || dest.isEmpty)
                    .padding(.top, 5)
                }
                .padding()
                .frame(width: 330, height: 300)
                .background(Color.white)
                .cornerRadius(15)
                .shadow(radius: 5)
                .padding(.top, 20)
                
                VStack(alignment: .leading, spacing: 5){
                    Text("Chep bus tickets")
                        .font(.title3)
                        .bold()
                    Text("From chennai to tuticorin")
                        .font(.subheadline)
                        .foregroundColor(.black.opacity(0.5))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 20)
                
                // Ticket Cards
                VStack(spacing: 20) {
                    ForEach(sampleTickets) { ticket in
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Text("\(ticket.from) ➝ \(ticket.to)")
                                    .font(.headline)
                                    .bold()
                                Spacer()
                                Text(ticket.price)
                                    .font(.headline)
                                    .foregroundColor(.green)
                            }
                            Text("Departure: \(ticket.departure)")
                                .font(.subheadline)
                            Text("Arrival: \(ticket.arrival)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            
                            Button(action: {
                                // Booking logic goes here
                            }) {
                                Text("Book Now")
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .bold()
                                    .background(Color.orange)
                                    .foregroundColor(.white)
                                    .cornerRadius(15)
                                    .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 5)

                            }
                        }
                        .padding()
                        .frame(width: 330)
                        .background(Color.white)
                        .cornerRadius(15)
                        .shadow(radius: 4)
                    }
                }
                .padding(.top, 20)
                
//                .sheet(isPresented: $showingResults) {
//                    NavigationStack {
//
//                    }
//                }
            }.padding()
        }
    }
}
