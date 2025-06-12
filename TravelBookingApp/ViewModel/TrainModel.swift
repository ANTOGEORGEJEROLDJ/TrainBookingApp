//
//  TrainModel.swift
//  TravelBookingApp
//
//  Created by Paranjothi iOS MacBook Pro on 12/06/25.
//

import SwiftUI
import Foundation

struct TrainModel: Identifiable {
  let id: UUID
  let name: String
  let source: StationModel
  let destination: StationModel
  let departure: Date
  let arrival: Date
  let classes: [String]
  let prices: [String: Double]
}
