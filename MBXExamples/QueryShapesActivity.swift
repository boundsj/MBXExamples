import Mapbox

class CustomFeature: MGLPointFeature {}

class QueryShapesActivity: NSObject, MapboxMapActivity {

    let centerCoordinate = CLLocationCoordinate2DMake(22.286394, 114.149139)

    func update(mapView: MGLMapView) {
        mapView.delegate = self
        mapView.setCenter(centerCoordinate, zoomLevel: 14, animated: false)
    }

}

extension QueryShapesActivity: MGLMapViewDelegate {

    func mapView(_ mapView: MGLMapView, didFinishLoading style: MGLStyle) {
        let feature = CustomFeature()
        feature.coordinate = centerCoordinate
        feature.attributes = ["hexColor": "#00ff00"]

        let shapeSource = MGLShapeSource(identifier: "shape-source", features: [feature], options: nil)
        style.addSource(shapeSource)

        let circleStyleLayer = MGLCircleStyleLayer(identifier: "circle-layer", source: shapeSource)
        circleStyleLayer.circleColor = MGLStyleValue(
            interpolationMode: .identity,
            sourceStops: nil,
            attributeName: "hexColor",
            options: [.defaultValue: MGLStyleValue<UIColor>(rawValue: .red)]
        )
        circleStyleLayer.circleRadius = MGLStyleValue<NSNumber>(rawValue: 15)
        style.addLayer(circleStyleLayer)

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0)  {
            let point = mapView.convert(self.centerCoordinate, toPointTo: mapView)
            let features = mapView.visibleFeatures(at: point)
            let roundTripFeature = features.filter { return $0 === feature; }
            print(roundTripFeature)
        }
    }

}
