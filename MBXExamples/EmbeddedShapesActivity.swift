import Mapbox

class EmbeddedShapesActivity: NSObject, MapboxMapActivity {
    
    var source : MGLShapeSource!
    var mapView: MGLMapView!

    let centerCoordinate = CLLocationCoordinate2D(latitude: 48.5, longitude: -73.2)

    func update(mapView: MGLMapView) {
        mapView.styleURL = MGLStyle.outdoorsStyleURL(withVersion: 9)
        mapView.delegate = self
        mapView.setCenter(centerCoordinate, zoomLevel: 17, animated: false)
        self.mapView = mapView
    }

}

extension EmbeddedShapesActivity: MGLMapViewDelegate {

    func mapView(_ mapView: MGLMapView, didFinishLoading style: MGLStyle) {

        
        // So that the features are only added once.
        if mapView.styleURL != MGLStyle.darkStyleURL(withVersion: 9) {
            
            var features = Array<MGLPointFeature>()
            let point1 = MGLPointFeature()
            point1.coordinate = CLLocationCoordinate2D(latitude: 48.5, longitude: -73.2)
            features.append(point1)
            
            let point2 = MGLPointFeature()
            point2.coordinate = CLLocationCoordinate2D(latitude: 35.8, longitude: -71.8)
            features.append(point2)
            
            let shapeCollection = MGLShapeCollectionFeature(shapes: features)
            source = MGLShapeSource(identifier:"circle-source", shape: shapeCollection, options: nil)
            mapView.style?.addSource(source)
            
            let circleLayer = MGLCircleStyleLayer(identifier:"circle-layer", source: source)
            mapView.style?.addLayer(circleLayer)
                        
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: { 
                self.removeFeatures()
                mapView.styleURL = MGLStyle.darkStyleURL(withVersion: 9)
            })
        }
        
        
    }
    
    
    func removeFeatures() {
        let filtered = [MGLShape]()
        let newShapeCollection = MGLShapeCollectionFeature(shapes: filtered)
        
        self.source?.shape = newShapeCollection
    }

}
