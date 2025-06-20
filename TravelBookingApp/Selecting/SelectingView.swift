//
//  SelectingView.swift
//  TravelBookingApp
//
//  Created by Paranjothi iOS MacBook Pro on 13/06/25.
//

import SwiftUI

struct SelectingView: View {
    var body: some View {
        NavigationStack {
            VStack {
                VStack{
                    HStack {
                        Button(action: {}) {
                            Image("")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 45, height: 45)
                                .cornerRadius(15)
                        }
                        
                        Text("Select Your Travel Mode")
                            .font(.headline)
                            .padding(.leading, 20)
                        
                        Spacer()
                    }
                    .padding()
                }.padding()
                    .padding(.top, -40)

                ScrollView {
                    VStack(spacing: 30) {
                        // Bus
                        NavigationLink(destination: MainTabView(selectedMode: .bus)) {
                            SelectingCard(title: "Bus Traveling", image: "busImage", color: .red)
                        }

                        // Train
                        NavigationLink(destination: MainTabView(selectedMode: .train)) {
                            SelectingCard(title: "Train Traveling", image: "TrainImage", color: .orange)
                        }
                    }
                    .padding()
                    .padding(.top, 100)
                }
            }
        } .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    SelectingView()
}
