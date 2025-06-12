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
    
    @State private var selectedClass = ""
    @State private var passengerName = ""
    @State private var travelDate = Date()
    @State private var showingResults = false
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.orange.opacity(0.15), .white]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            ).ignoresSafeArea()
            ScrollView{
                VStack{
                    
                    Text("Book Ticket")
                        .font(.title)
                        .bold()
                    
                    VStack(alignment: .leading ,spacing: 10) {
                        Text("Train")
                            .font(.title)
                            .bold()
                        
                        
                        HStack{
                            Text(train.name)
                                .font(.headline)
                            
                            Spacer()
                            
                            Picker("Class", selection: $selectedClass) {
                                ForEach(train.classes, id: \.self) { cls in
                                    Text(cls)
                                }
                            }
                            .padding()
                            .frame(width: 50, height: 50, alignment: .center)
                            .background(Color.white.opacity(0.8))
                            .cornerRadius(15)
                            .shadow(radius: 3)
                            
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(15)
                        .frame(width: 300, height: 70)
                        
                        
                        
                        TextField("Passenger Name", text: $passengerName)
                            .font(.subheadline)
                            .bold()
                            .padding()
                            .font(.subheadline)
                            .background(Color.white)
                            .cornerRadius(15)
                            .frame(width: 300, height: 70)
                        
                    }.padding()
                        .frame(width: 350)
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(15)
                        .shadow(radius: 5)
                    
                    
                    
                    
                    
                    DatePicker("Travel Date", selection: $travelDate, displayedComponents: .date)
                        .padding()
                        .font(.subheadline)
                        .bold()
                        .frame(width: 350, height: 90)
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(15)
                        .shadow(radius: 5)
                        .padding(.top, 40)
                    
                    
                    VStack{
                        Section("Fare") {
                            Text("₹\(fare, specifier: "%.2f")")
                                .font(.subheadline)
                                .bold()
                        }
                        
                        
                        NavigationLink(
                            destination: WalletView(),
                            isActive: $showingResults
                        ) {
                            EmptyView()
                        }
                        Button(action: {
                            saveTicket()
//                            dismiss()
                            showingResults = true
                        }) {
                            Text("Book Ticket")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.orange)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(selectedClass == passengerName ? Color.orange : Color.clear, lineWidth: 3)
                                )
                        }
                        .disabled(selectedClass.isEmpty || passengerName.isEmpty)
                    }
                    .padding()
                    .frame(width: 350)
                    .background(.ultraThinMaterial)
                    .cornerRadius(15)
                    .shadow(radius: 5)
                    .padding(.top, 10)
                    
                    //                .padding()
                    //                .frame(width: 350, height: 650)
                    //                .background(Color.white)
                    //                .cornerRadius(15)
                    //                .shadow(radius: 5)
                    
                }.padding()
            }
        }
    }
    
    var fare: Double {
        train.prices[selectedClass] ?? (distance * 0.5)
    }
    
    func saveTicket() {
        let ticket = TicketEntity(context: ctx)
        ticket.id = UUID()
        ticket.trainName = train.name
        ticket.source = train.source.name
        ticket.destination = train.destination.name
        ticket.travelDate = travelDate
        ticket.seatClass = selectedClass
        ticket.fare = fare
        try? ctx.save()
    }
}
