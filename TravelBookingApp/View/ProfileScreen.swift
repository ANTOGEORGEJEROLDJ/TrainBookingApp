//
//  ProfileScreen.swift
//  TravelBookingApp
//
//  Created by Paranjothi iOS MacBook Pro on 12/06/25.
//

import SwiftUI

struct ProfileScreen: View {
    var body: some View {
        VStack {
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.blue)
            Text("Welcome, Traveler!")
                .font(.title2)
                .bold()
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ProfileScreen()
}
