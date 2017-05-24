import Mapbox

class EmbeddedShapesActivity: NSObject, MapboxMapActivity {

    let centerCoordinate = CLLocationCoordinate2DMake(39.5720821, -84.367218)

    func update(mapView: MGLMapView) {
        mapView.styleURL = MGLStyle.outdoorsStyleURL(withVersion: 9)
        mapView.delegate = self
        mapView.setCenter(centerCoordinate, zoomLevel: 17, animated: false)
    }

}

extension EmbeddedShapesActivity: MGLMapViewDelegate {

    func mapView(_ mapView: MGLMapView, didFinishLoading style: MGLStyle) {

        let point = MGLPointFeature()
        let hotSpot = CLLocationCoordinate2DMake(39.5718, -84.36742)
        point.coordinate = hotSpot

        let source = MGLShapeSource(identifier: "test", features: [point], options: nil)
        style.addSource(source)

        let circleStyleLayer = MGLCircleStyleLayer(identifier: "test", source: source)
        circleStyleLayer.circleColor = MGLStyleValue(rawValue: .red)
        circleStyleLayer.circleRadius = MGLStyleValue(rawValue: 50)
        circleStyleLayer.circleBlur = MGLStyleValue(rawValue: 1)

        style.addLayer(circleStyleLayer)

        for layer in style.layers {
            print(layer.identifier)
        }
    }

}
