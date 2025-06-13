import SwiftUI
import MapKit

struct TrainDetailView: View {
    let train: TrainModel

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {

                // Train name header
                VStack(spacing: 8) {
                    Text(train.name)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    Text("🚆 Travel Details")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }

                // Route Info Card
                routeInfoCard
                
                HStack{
                    // Stops
                    VStack(alignment: .leading, spacing: 10) {
                        Text("🛑 Stops")
                            .font(.headline)
                        ForEach(train.stops, id: \.self) { stop in
                            Text("• \(stop)")
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding()
                    .frame(width: 180, height: 300)
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(12)
                    .shadow(radius: 4)
                    
                    // Classes and Pricing
                    VStack(alignment: .leading, spacing: 10) {
                        Text("💺 Available Classes")
                            .font(.headline)
                        ForEach(train.classes, id: \.self) { cls in
                            if let price = train.prices[cls] {
                                HStack {
                                    Text(cls)
                                    Spacer()
                                    Text("₹\(price)")
                                        .font(.system(size: 12))
                                        .bold()
                                }
                                .padding(.vertical, 4)
                            }
                        }
                    }
                    .padding()
                    .frame(width: 200, height: 300)
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(12)
                    .shadow(radius: 4)
                    
                }

                // Buttons
                HStack(spacing: 16) {
                    NavigationLink(destination: RouteMapView(train: train)) {
                        Text("🗺 Route")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(LinearGradient(colors: [.blue, .cyan], startPoint: .topLeading, endPoint: .bottomTrailing))
                            .foregroundColor(.white)
                            .cornerRadius(14)
                    }

                    NavigationLink(destination: BookingFormView(train: train, distance: calculateDistance(from: train.source.coordinate, to: train.destination.coordinate))) {
                        Text("🎫 Book Now")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(LinearGradient(colors: [.orange, .red], startPoint: .topLeading, endPoint: .bottomTrailing))
                            .foregroundColor(.white)
                            .cornerRadius(14)
                    }
                }
            }
            .padding(.all, -20)
        }
        .padding()
        .navigationTitle("Train Details")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var routeInfoCard: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("From:")
                    .fontWeight(.semibold)
                Text(train.source.name)
                Spacer()
                Text("To:")
                    .fontWeight(.semibold)
                Text(train.destination.name)
            }

            HStack {
                Text("🕒 Departure:")
                    .font(.subheadline)
                Text(train.departure.formatted(date: .omitted, time: .shortened))
                Spacer()
                Text("🕒 Arrival:")
                    .fontWeight(.semibold)
                Text(train.arrival.formatted(date: .omitted, time: .shortened))
            }

            let duration = train.arrival.timeIntervalSince(train.departure) / 3600
            Text(String(format: "⏱ Duration: %.1f hours", duration))
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color.white.opacity(0.8))
        .cornerRadius(12)
        .shadow(radius: 4)
    }

    // Distance calculation
    func calculateDistance(from: CLLocationCoordinate2D, to: CLLocationCoordinate2D) -> Double {
        let sourceLocation = CLLocation(latitude: from.latitude, longitude: from.longitude)
        let destinationLocation = CLLocation(latitude: to.latitude, longitude: to.longitude)
        let distanceInMeters = sourceLocation.distance(from: destinationLocation)
        return round((distanceInMeters / 1000.0) * 10) / 10
    }
}
