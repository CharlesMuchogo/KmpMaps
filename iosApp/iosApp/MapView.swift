
import SwiftUI
import MapKit
import ComposeApp
import Foundation
import Security


class IOSNativeViewFactory: NativeViewFactory {
    static var shared = IOSNativeViewFactory()
    func createMapView(latitude: Double, longitude: Double) -> UIViewController {
        let view = MapView(latitude: latitude, longitude: longitude)

        return UIHostingController(rootView: view)
    }
}


struct MapView: View {
    let latitude: Double
    let longitude: Double
    
    var body: some View {
        if #available(iOS 17.0, *) {
                 Map(initialPosition: .region(region)) {
                     Marker("Location", coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
                 }
             } else {
                 Map(coordinateRegion: .constant(region), annotationItems: [LocationMarker(latitude: latitude, longitude: longitude)]) { location in
                     MapMarker(coordinate: location.coordinate, tint: .red)
                 }
             }
    }
    
    private var region: MKCoordinateRegion {
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude),
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        )
    }
}

struct LocationMarker: Identifiable {
    let id = UUID()
    let latitude: Double
    let longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

#Preview {
    ContentView()
}

