//
//  ShowingTicketView.swift
//  TravelBookingApp
//
//  Created by Paranjothi iOS MacBook Pro on 12/06/25.
//

import SwiftUI
import CoreData

struct ShowingTicketView: View {
    let ticket: TicketEntity

    var body: some View {
        VStack(spacing: 30) {
            Text("🎫 E-Ticket")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundColor(.black.opacity(0.8))
                .padding(.top)

            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.orange, Color.red]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .shadow(radius: 10)

                VStack(spacing: 20) {
                    HStack {
                        VStack(alignment: .leading, spacing: 6) {
                            Label("Train", systemImage: "train.side.front.car")
                            Text(ticket.trainName ?? "N/A")
                                .font(.title3)
                                .bold()
                        }

                        Spacer()

                        VStack(alignment: .trailing, spacing: 6) {
                            Label("Date", systemImage: "calendar")
                            if let date = ticket.travelDate {
                                Text("\(date, formatter: dateFormatter)")
                                    .font(.body)
                                    .bold()
                            }
                        }
                    }

                    Divider().background(Color.white)

                    HStack {
                        VStack(alignment: .leading, spacing: 6) {
                            Label("From", systemImage: "location.fill")
                            Text(ticket.source ?? "N/A")
                                .font(.title3)
                                .bold()
                        }

                        Spacer()

                        VStack(alignment: .trailing, spacing: 6) {
                            Label("To", systemImage: "flag.fill")
                            Text(ticket.destination ?? "N/A")
                                .font(.title3)
                                .bold()
                        }
                    }

                    Divider().background(Color.white)

                    HStack {
                        Label("Class", systemImage: "seat.side.rear.passenger")
                        Spacer()
                        Text(ticket.seatClass ?? "N/A")
                            .bold()
                    }

                    HStack {
                        Label("Passenger", systemImage: "person.crop.circle")
                        Spacer()
                        Text(ticket.passengerName ?? "N/A")
                            .bold()
                    }

                    HStack {
                        Label("Fare", systemImage: "creditcard")
                        Spacer()
                        Text("₹\(ticket.fare, specifier: "%.2f")")
                            .bold()
                    }

                }
                .foregroundColor(.white)
                .padding()
            }
            .frame(width: 340, height: 450)
            .overlay(
                TicketEdgePunch()
                    .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                    .foregroundColor(.white)
                    .opacity(0.6)
            )

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color(.systemGray6), Color(.systemGray5)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
        )
    }

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
}
struct TicketEdgePunch: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        let circleRadius: CGFloat = 6
        let spacing: CGFloat = 12
        let count = Int(rect.height / spacing)

        for i in 0..<count {
            let y = CGFloat(i) * spacing + spacing / 2
            path.addEllipse(in: CGRect(x: -circleRadius, y: y, width: circleRadius * 2, height: circleRadius * 2))
            path.addEllipse(in: CGRect(x: rect.maxX - circleRadius, y: y, width: circleRadius * 2, height: circleRadius * 2))
        }

        return path
    }
}
