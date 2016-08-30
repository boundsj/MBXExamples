import Mapbox

class SimpleMapActivity: NSObject, MapboxMapActivity {
    
    func update(mapView: MGLMapView) {
        // center the map on New York, NY and zoom in a bit
        mapView.setCenter(CLLocationCoordinate2DMake(40.73581, -73.99155), zoomLevel: 11, animated: true)
    }
    
}
