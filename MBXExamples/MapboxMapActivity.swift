import Foundation
import Mapbox

protocol MapboxMapActivity: MGLMapViewDelegate {
    
    func update(mapView: MGLMapView)
    
}
