//
//  BusStandSearchViewModel.swift
//  TravelBookingApp
//
//  Created by Paranjothi iOS MacBook Pro on 13/06/25.
//

    import Foundation
    import SwiftUI

    class BusStandSearchViewModel: ObservableObject {
        @Published var allTrains: [TrainModel] = [
            TrainModel(
                        id: UUID(),
                        name: "Chennai - Madurai Express",
                        source: StationModel(id: UUID(), name: "Chennai", coordinate: .init(latitude: 13.0827, longitude: 80.2707)),
                        destination: StationModel(id: UUID(), name: "Madurai", coordinate: .init(latitude: 9.9252, longitude: 78.1198)),
                        departure: Date(),
                        arrival: Date().addingTimeInterval(8 * 3600),
                        classes: ["AC", "Non AC", "Sleeper"],
                        prices: ["AC": 750, "Non AC": 500, "Sleeper": 600]
                    ),
                    TrainModel(
                        id: UUID(),
                        name: "Coimbatore - Trichy Deluxe",
                        source: StationModel(id: UUID(), name: "Coimbatore", coordinate: .init(latitude: 11.0168, longitude: 76.9558)),
                        destination: StationModel(id: UUID(), name: "Trichy", coordinate: .init(latitude: 10.7905, longitude: 78.7047)),
                        departure: Date(),
                        arrival: Date().addingTimeInterval(5 * 3600),
                        classes: ["AC", "Sleeper"],
                        prices: ["AC": 620, "Sleeper": 400]
                    ),
                    TrainModel(
                        id: UUID(),
                        name: "Salem - Erode Local",
                        source: StationModel(id: UUID(), name: "Salem", coordinate: .init(latitude: 11.6643, longitude: 78.1460)),
                        destination: StationModel(id: UUID(), name: "Erode", coordinate: .init(latitude: 11.3410, longitude: 77.7172)),
                        departure: Date(),
                        arrival: Date().addingTimeInterval(2 * 3600),
                        classes: ["Non AC", "Sleeper"],
                        prices: ["Non AC": 200, "Sleeper": 250]
                    ),
                    TrainModel(
                        id: UUID(),
                        name: "Chennai - Coimbatore Fast Track",
                        source: StationModel(id: UUID(), name: "Chennai", coordinate: .init(latitude: 13.0827, longitude: 80.2707)),
                        destination: StationModel(id: UUID(), name: "Coimbatore", coordinate: .init(latitude: 11.0168, longitude: 76.9558)),
                        departure: Date(),
                        arrival: Date().addingTimeInterval(9 * 3600),
                        classes: ["AC", "Non AC", "Sleeper"],
                        prices: ["AC": 800, "Non AC": 600, "Sleeper": 650]
                    ),
                    TrainModel(
                        id: UUID(),
                        name: "Trichy - Thanjavur City Bus",
                        source: StationModel(id: UUID(), name: "Trichy", coordinate: .init(latitude: 10.7905, longitude: 78.7047)),
                        destination: StationModel(id: UUID(), name: "Thanjavur", coordinate: .init(latitude: 10.7867, longitude: 79.1391)),
                        departure: Date(),
                        arrival: Date().addingTimeInterval(1.5 * 3600),
                        classes: ["Non AC"],
                        prices: ["Non AC": 150]
                    ),
                    TrainModel(
                        id: UUID(),
                        name: "Tirunelveli - Madurai Express",
                        source: StationModel(id: UUID(), name: "Tirunelveli", coordinate: .init(latitude: 8.7139, longitude: 77.7567)),
                        destination: StationModel(id: UUID(), name: "Madurai", coordinate: .init(latitude: 9.9252, longitude: 78.1198)),
                        departure: Date(),
                        arrival: Date().addingTimeInterval(4 * 3600),
                        classes: ["Sleeper", "AC"],
                        prices: ["Sleeper": 300, "AC": 450]
                    ),
                    TrainModel(
                        id: UUID(),
                        name: "Erode - Chennai AC Special",
                        source: StationModel(id: UUID(), name: "Erode", coordinate: .init(latitude: 11.3410, longitude: 77.7172)),
                        destination: StationModel(id: UUID(), name: "Chennai", coordinate: .init(latitude: 13.0827, longitude: 80.2707)),
                        departure: Date(),
                        arrival: Date().addingTimeInterval(7 * 3600),
                        classes: ["AC", "Sleeper"],
                        prices: ["AC": 850, "Sleeper": 600]
                    ),
                    TrainModel(
                        id: UUID(),
                        name: "Chennai - Tuticorin Night Rider",
                        source: StationModel(id: UUID(), name: "Chennai", coordinate: .init(latitude: 13.0827, longitude: 80.2707)),
                        destination: StationModel(id: UUID(), name: "Tuticorin", coordinate: .init(latitude: 8.7642, longitude: 78.1348)),
                        departure: Date(),
                        arrival: Date().addingTimeInterval(10 * 3600),
                        classes: ["Sleeper", "AC"],
                        prices: ["Sleeper": 550, "AC": 700]
                    ),
                    TrainModel(
                        id: UUID(),
                        name: "Tiruchendur - Madurai Local",
                        source: StationModel(id: UUID(), name: "Tiruchendur", coordinate: .init(latitude: 8.4998, longitude: 78.1193)),
                        destination: StationModel(id: UUID(), name: "Madurai", coordinate: .init(latitude: 9.9252, longitude: 78.1198)),
                        departure: Date(),
                        arrival: Date().addingTimeInterval(4.5 * 3600),
                        classes: ["Non AC"],
                        prices: ["Non AC": 280]
                    ),
                    TrainModel(
                        id: UUID(),
                        name: "Vellore - Trichy Express",
                        source: StationModel(id: UUID(), name: "Vellore", coordinate: .init(latitude: 12.9165, longitude: 79.1325)),
                        destination: StationModel(id: UUID(), name: "Trichy", coordinate: .init(latitude: 10.7905, longitude: 78.7047)),
                        departure: Date(),
                        arrival: Date().addingTimeInterval(6 * 3600),
                        classes: ["AC", "Sleeper"],
                        prices: ["AC": 720, "Sleeper": 480]
                    )
                ]
        
        @Published var filteredTrains: [TrainModel] = []
        
        func searchTrains(from: String, to: String) {
            filteredTrains = allTrains.filter {
                $0.source.name.lowercased().contains(from.lowercased()) &&
                $0.destination.name.lowercased().contains(to.lowercased())
            }
        }
    }



////
////  BusStandSearchViewModel.swift
////  TravelBookingApp
////
////  Created by Paranjothi iOS MacBook Pro on 13/06/25.
////
//
//import Foundation
//import SwiftUI
//import CoreLocation
//
//
//class BusStandSearchViewModel: ObservableObject {
//    @Published var allTrains: [TrainModel] = [
//        TrainModel(
//            id: UUID(),
//            name: "Chennai - Madurai Express",
//            source: StationModel(id: UUID(), name: "Chennai", coordinate: .init(latitude: 13.0827, longitude: 80.2707)),
//            destination: StationModel(id: UUID(), name: "Madurai", coordinate: .init(latitude: 9.9252, longitude: 78.1198)),
//            departure: Date(),
//            arrival: Date().addingTimeInterval(8 * 3600),
//            classes: ["AC", "Non AC", "Sleeper"],
//            prices: ["AC": 750, "Non AC": 500, "Sleeper": 600]
//        ),
//        TrainModel(
//            id: UUID(),
//            name: "Coimbatore - Trichy Deluxe",
//            source: StationModel(id: UUID(), name: "Coimbatore", coordinate: .init(latitude: 11.0168, longitude: 76.9558)),
//            destination: StationModel(id: UUID(), name: "Trichy", coordinate: .init(latitude: 10.7905, longitude: 78.7047)),
//            departure: Date(),
//            arrival: Date().addingTimeInterval(5 * 3600),
//            classes: ["AC", "Sleeper"],
//            prices: ["AC": 620, "Sleeper": 400]
//        ),
//        TrainModel(
//            id: UUID(),
//            name: "Salem - Erode Local",
//            source: StationModel(id: UUID(), name: "Salem", coordinate: .init(latitude: 11.6643, longitude: 78.1460)),
//            destination: StationModel(id: UUID(), name: "Erode", coordinate: .init(latitude: 11.3410, longitude: 77.7172)),
//            departure: Date(),
//            arrival: Date().addingTimeInterval(2 * 3600),
//            classes: ["Non AC", "Sleeper"],
//            prices: ["Non AC": 200, "Sleeper": 250]
//        ),
//        TrainModel(
//            id: UUID(),
//            name: "Chennai - Coimbatore Fast Track",
//            source: StationModel(id: UUID(), name: "Chennai", coordinate: .init(latitude: 13.0827, longitude: 80.2707)),
//            destination: StationModel(id: UUID(), name: "Coimbatore", coordinate: .init(latitude: 11.0168, longitude: 76.9558)),
//            departure: Date(),
//            arrival: Date().addingTimeInterval(9 * 3600),
//            classes: ["AC", "Non AC", "Sleeper"],
//            prices: ["AC": 800, "Non AC": 600, "Sleeper": 650]
//        ),
//        TrainModel(
//            id: UUID(),
//            name: "Trichy - Thanjavur City Bus",
//            source: StationModel(id: UUID(), name: "Trichy", coordinate: .init(latitude: 10.7905, longitude: 78.7047)),
//            destination: StationModel(id: UUID(), name: "Thanjavur", coordinate: .init(latitude: 10.7867, longitude: 79.1391)),
//            departure: Date(),
//            arrival: Date().addingTimeInterval(1.5 * 3600),
//            classes: ["Non AC"],
//            prices: ["Non AC": 150]
//        ),
//        TrainModel(
//            id: UUID(),
//            name: "Tirunelveli - Madurai Express",
//            source: StationModel(id: UUID(), name: "Tirunelveli", coordinate: .init(latitude: 8.7139, longitude: 77.7567)),
//            destination: StationModel(id: UUID(), name: "Madurai", coordinate: .init(latitude: 9.9252, longitude: 78.1198)),
//            departure: Date(),
//            arrival: Date().addingTimeInterval(4 * 3600),
//            classes: ["Sleeper", "AC"],
//            prices: ["Sleeper": 300, "AC": 450]
//        ),
//        TrainModel(
//            id: UUID(),
//            name: "Erode - Chennai AC Special",
//            source: StationModel(id: UUID(), name: "Erode", coordinate: .init(latitude: 11.3410, longitude: 77.7172)),
//            destination: StationModel(id: UUID(), name: "Chennai", coordinate: .init(latitude: 13.0827, longitude: 80.2707)),
//            departure: Date(),
//            arrival: Date().addingTimeInterval(7 * 3600),
//            classes: ["AC", "Sleeper"],
//            prices: ["AC": 850, "Sleeper": 600]
//        ),
//        TrainModel(
//            id: UUID(),
//            name: "Chennai - Tuticorin Night Rider",
//            source: StationModel(id: UUID(), name: "Chennai", coordinate: .init(latitude: 13.0827, longitude: 80.2707)),
//            destination: StationModel(id: UUID(), name: "Tuticorin", coordinate: .init(latitude: 8.7642, longitude: 78.1348)),
//            departure: Date(),
//            arrival: Date().addingTimeInterval(10 * 3600),
//            classes: ["Sleeper", "AC"],
//            prices: ["Sleeper": 550, "AC": 700]
//        ),
//        TrainModel(
//            id: UUID(),
//            name: "Tiruchendur - Madurai Local",
//            source: StationModel(id: UUID(), name: "Tiruchendur", coordinate: .init(latitude: 8.4998, longitude: 78.1193)),
//            destination: StationModel(id: UUID(), name: "Madurai", coordinate: .init(latitude: 9.9252, longitude: 78.1198)),
//            departure: Date(),
//            arrival: Date().addingTimeInterval(4.5 * 3600),
//            classes: ["Non AC"],
//            prices: ["Non AC": 280]
//        ),
//        TrainModel(
//            id: UUID(),
//            name: "Vellore - Trichy Express",
//            source: StationModel(id: UUID(), name: "Vellore", coordinate: .init(latitude: 12.9165, longitude: 79.1325)),
//            destination: StationModel(id: UUID(), name: "Trichy", coordinate: .init(latitude: 10.7905, longitude: 78.7047)),
//            departure: Date(),
//            arrival: Date().addingTimeInterval(6 * 3600),
//            classes: ["AC", "Sleeper"],
//            prices: ["AC": 720, "Sleeper": 480]
//        )
//    ]
//    
//    @Published var filteredTrains: [TrainModel] = []
//    
//    func searchTrains(from: String, to: String) {
//        filteredTrains = allTrains.filter {
//            $0.source.name.lowercased().contains(from.lowercased()) &&
//            $0.destination.name.lowercased().contains(to.lowercased())
//        }
//    }
//}
