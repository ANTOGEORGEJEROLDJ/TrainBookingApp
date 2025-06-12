//
//  StationSearchView.swift
//  TravelBookingApp
//
//  Created by Paranjothi iOS MacBook Pro on 12/06/25.
//

import SwiftUI

struct StationSearchView: View {
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
                    Text("Railway Ticket Booking").font(.title2).bold()
                    TextField("Source station", text: $src).textFieldStyle(.plain)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.white.opacity(0.8))
                        .shadow(radius: 3)
                        .cornerRadius(15)
                        
                    TextField("Destination station", text: $dest).textFieldStyle(.plain)
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
                            .background(Color.orange.opacity(0.4))
                            .foregroundColor(.black.opacity(0.7))
                            .font(.headline)
                            .cornerRadius(15)
                            .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 5)
                    }
                    .disabled(src.isEmpty || dest.isEmpty)
                    .padding(.top, 35)
                }
                .padding()
                .frame(width: 330, height: 300)
                .background(Color.white)
                .cornerRadius(15)
                .shadow(radius: 5)
                .padding(.top, 45)
                
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
                
//                .sheet(isPresented: $showingResults) {
//                    NavigationStack {
//                        
//                    }
//                }
            }.padding()
        }
    }
}
