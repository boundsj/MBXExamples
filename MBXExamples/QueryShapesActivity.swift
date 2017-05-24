import Mapbox

class QueryShapesActivity: NSObject, MapboxMapActivity {

    var shapeSource: MGLShapeSource!
    var circleStyleLayer: MGLCircleStyleLayer!
    var newCircleStyleLayer: MGLCircleStyleLayer!

    var isStyleLoaded: Bool = false

    let centerCoordinate = CLLocationCoordinate2DMake(22.286394, 114.149139)

    func update(mapView: MGLMapView) {
        mapView.delegate = self
        mapView.setCenter(centerCoordinate, zoomLevel: 14, animated: false)
    }

}

extension QueryShapesActivity: MGLMapViewDelegate {

    func generateFeature(centerCoordinate: CLLocationCoordinate2D) -> MGLPointFeature {
        let feature = MGLPointFeature()
        feature.coordinate = centerCoordinate
        feature.attributes = ["hexColor": "#ff00ff"]
        feature.identifier = 42
        feature.title = "demo"

        return feature
    }

    func mapView(_ mapView: MGLMapView, didFinishLoading style: MGLStyle) {
        isStyleLoaded = true

        let feature = generateFeature(centerCoordinate: mapView.centerCoordinate)
        feature.attributes = ["status": "old"]
        let featureCollection = MGLShapeCollectionFeature(shapes: [feature])

        shapeSource = MGLShapeSource(identifier: "shape-source", shape: featureCollection, options: nil)
        style.addSource(shapeSource)

        circleStyleLayer = MGLCircleStyleLayer(identifier: "circle-layer", source: shapeSource)
        circleStyleLayer.predicate = NSPredicate(format: "status == 'old'")
        circleStyleLayer.circleColor = MGLStyleValue(
            interpolationMode: .identity,
            sourceStops: nil,
            attributeName: "hexColor",
            options: [.defaultValue: MGLStyleValue<UIColor>(rawValue: .red)]
        )
        circleStyleLayer.circleRadius = MGLStyleValue<NSNumber>(rawValue: 25)
        style.addLayer(circleStyleLayer)

        // Add a new style layer so that new features show a transition
        newCircleStyleLayer = MGLCircleStyleLayer(identifier: "new-circle-layer", source: shapeSource)
        newCircleStyleLayer.predicate = NSPredicate(format: "status == 'new'")
        newCircleStyleLayer.circleColor = MGLStyleValue(
            interpolationMode: .identity,
            sourceStops: nil,
            attributeName: "hexColor",
            options: [.defaultValue: MGLStyleValue<UIColor>(rawValue: .red)]
        )
        newCircleStyleLayer.circleRadius = MGLStyleValue<NSNumber>(rawValue: 5)
        mapView.style?.addLayer(newCircleStyleLayer!)
    }

    func mapView(_ mapView: MGLMapView, regionDidChangeAnimated animated: Bool) {
        guard isStyleLoaded else {
            return
        }

        newCircleStyleLayer.circleRadiusTransition = MGLTransition(duration: 0, delay: 0)
        newCircleStyleLayer.circleRadius = MGLStyleValue<NSNumber>(rawValue: 5)

        // Add a new feature
        let feature = generateFeature(centerCoordinate: mapView.centerCoordinate)
        feature.attributes = ["status": "new"]
        let newFeatures = [feature]

        // Get all of the old features (as shapes), cast them to features, update their
        // attributes, and collect them again casted back to shape. Finally 
        // create a new shape colection to add back as the shape to the source
        let shapeCollectionFeature = shapeSource.shape as! MGLShapeCollectionFeature
        let shapes = shapeCollectionFeature.shapes.map { $0 as! MGLFeature }
        let existingFeatures: [MGLShape] = shapes.map { (shape: MGLFeature) -> MGLShape in
            shape.attributes = ["status": "old"]
            return shape as! MGLShape
        }
        let allFeatures = newFeatures + existingFeatures as [MGLShape]
        let shapeCollection = MGLShapeCollectionFeature(shapes: allFeatures)
        shapeSource.shape = shapeCollection

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            self.newCircleStyleLayer.circleRadiusTransition = MGLTransition(duration: 2, delay: 0)
            self.newCircleStyleLayer.circleRadius = MGLStyleValue<NSNumber>(rawValue: 25)
        }

    }

}
