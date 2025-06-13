//
//  BusTicketRow.swift
//  TravelBookingApp
//
//  Created by Paranjothi iOS MacBook Pro on 13/06/25.
//

import SwiftUI

struct BusTicketRow: View {
    
    let ticket: BusTicketCard
    var onBook: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8){
            HStack{
                VStack {
                    Text("\(ticket.from)-> \(ticket.to)")
                        .font(.subheadline)
                        .bold()
                    
                    Text("Arrival: \(ticket.arrival)")
                        .padding()
                        .font(.system(size: 14))
                        .bold()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(15)
                        .shadow(radius: 3)
                    
                    Text(ticket.price)
                        .font(.title3)
                        .foregroundColor(.red)
                        .bold()
                }
                VStack{

                    Button(action: onBook) {
                        Text("Book Now")
                            .frame(width: 120)
                            .padding(.vertical, 10)
                            .background(Color.red)
                            .bold()
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.top, 10)
                    }
                    Spacer()
                        
                        Text("Departure: \(ticket.departure)")
                            .font(.subheadline)
                            .bold()
                            .padding(.bottom, 20)
                
                }
                
            }
        }.shadow(radius: 5)
    }
}

//#Preview {
//    BusTicketRow(ticket: "", onBook: Void)
//}
