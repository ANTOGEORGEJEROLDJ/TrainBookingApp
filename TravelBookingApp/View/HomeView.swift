//
//  ContentView.swift
//  TravelBookingApp
//
//  Created by Paranjothi iOS MacBook Pro on 12/06/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            ScrollView{
                VStack {
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
                    
                    VStack(spacing: 20){
                        
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
                    
                    VStack(spacing: 20){
                        
                    }
                    .padding()
                        .frame(width: 330, height: 170)
                        .background(Color.white)
                        .cornerRadius(15)
                        .shadow(radius: 5)
                        .padding(.top, 30)
                    
                }
            }
        }
        .padding()
    }
}

#Preview {
    HomeView()
}
