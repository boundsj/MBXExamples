import Mapbox

class EmbeddedShapesActivity: NSObject, MapboxMapActivity {

    let centerCoordinate = CLLocationCoordinate2DMake(39.5820821, -84.367218)

    func update(mapView: MGLMapView) {
        mapView.styleURL = MGLStyle.outdoorsStyleURL(withVersion: 9)
        mapView.delegate = self
        mapView.setCenter(centerCoordinate, zoomLevel: 17, animated: false)
    }

}

extension EmbeddedShapesActivity: MGLMapViewDelegate {

    func mapView(_ mapView: MGLMapView, didFinishLoading style: MGLStyle) {

        let point = MGLPointFeature()
        point.coordinate = CLLocationCoordinate2DMake(39.5820821, -84.367218)
        point.attributes = ["bike_count": 95]  // Assume a station can have a max of 100 bikes

        let source = MGLShapeSource(identifier: "shapeSource", shape: point, options: nil)
        style.addSource(source)

        // Represent the bike stop with a circle that is red as the bike_count approaches 0 and green as the bike_count approaches 100
        let circleStyleLayer = MGLCircleStyleLayer(identifier: "circleLayer", source: source)
        let stops : [Float:MGLStyleValue<UIColor>] = [
            0: MGLStyleValue<UIColor>(rawValue: .red),
            100: MGLStyleValue<UIColor>(rawValue: .green)
        ]
        circleStyleLayer.circleColor = MGLStyleValue(interpolationMode: .exponential, sourceStops: stops, attributeName: "bike_count", options: nil)
        circleStyleLayer.circleRadius = MGLStyleValue(rawValue: 18)
        style.addLayer(circleStyleLayer)
        
        // Add a label on top of the circle that displays the actual bike_count value
        let symbolStyleLayer = MGLSymbolStyleLayer(identifier: "symbolLayer", source: source)
        symbolStyleLayer.text = MGLStyleValue(rawValue: "{bike_count}")
        symbolStyleLayer.textColor = MGLStyleValue(rawValue: .white)
        style.addLayer(symbolStyleLayer)
        
        // After 5 seconds reduce the number of bikes from 95 to 10
        // Note: This simulates an update that could happen on a timer. You will need to save a reference to the source
        // or get it back from the style using `mapView.style?.source(withIdentifier:)`
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            point.attributes = ["bike_count": 10]
            source.shape = point
        }
    }

}
