//
//  RouteMapView.swift
//  TravelBookingApp
//
//  Created by Paranjothi iOS MacBook Pro on 12/06/25.
//

import SwiftUI
import MapKit

struct RouteMapView: View {
  let train: TrainModel
  @State private var route: MKRoute?

  var body: some View {
        VStack {
                MapView(route: route, src: train.source.coordinate, dst: train.destination.coordinate)
                    .frame(height: 650)
                Text("Distance: \(routeDistanceString)")
                    .padding(.vertical, 8)
            
          Spacer()
            
                }
                .padding()
                .navigationTitle("Route & Distance")
                .onAppear(perform: fetchRoute)
                
        }

  var routeDistanceString: String {
    String(format: "%.2f km", (route?.distance ?? 0)/1000)
        }

  func fetchRoute() {
    let req = MKDirections.Request()
    req.source = MKMapItem(placemark: MKPlacemark(coordinate: train.source.coordinate))
    req.destination = MKMapItem(placemark: MKPlacemark(coordinate: train.destination.coordinate))
    req.transportType = .automobile
    MKDirections(request: req).calculate { resp, _ in
      route = resp?.routes.first
    }
  }
}

struct MapView: UIViewRepresentable {
        let route: MKRoute?
        let src: CLLocationCoordinate2D
        let dst: CLLocationCoordinate2D

    func makeUIView(context: Context) -> MKMapView {
        let map = MKMapView()
        map.delegate = context.coordinator
        return map
    }

    func updateUIView(_ map: MKMapView, context: Context) {
        map.removeAnnotations(map.annotations)
        map.removeOverlays(map.overlays)

        map.addAnnotation(MKPlacemark(coordinate: src))
        map.addAnnotation(MKPlacemark(coordinate: dst))

    if let route = route {
        map.addOverlay(route.polyline)
        map.setVisibleMapRect(route.polyline.boundingMapRect, edgePadding: .init(top:50, left:20, bottom:20, right:20), animated: false)
        }
    }

    func makeCoordinator() -> MKMapViewDelegateHandler {
        MKMapViewDelegateHandler()
    }

  class MKMapViewDelegateHandler: NSObject, MKMapViewDelegate {
      func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
      let r = MKPolylineRenderer(overlay: overlay)
      r.strokeColor = .systemBlue
      r.lineWidth = 4
      return r
    }
  }
}
