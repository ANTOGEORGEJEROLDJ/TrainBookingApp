//
//  SelectingCard.swift
//  TravelBookingApp
//
//  Created by Paranjothi iOS MacBook Pro on 13/06/25.
//

import SwiftUI

struct SelectingCard: View {
    let title: String
    let image: String
    let color: Color

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.title3)
                    .bold()
                    .padding(.trailing, 10)
                    .foregroundColor(.black)
            }

            Spacer()

            Image(image) // ← This uses your asset image
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 130)
                .cornerRadius(19)
                .padding(.trailing, 10)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(13)
        .shadow(radius: 3)
    }
}

#Preview {
    SelectingCard(title: "Bus Traveling", image: "BusImage", color: .blue)
}
