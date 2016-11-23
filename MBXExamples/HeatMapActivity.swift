import Mapbox

class HeatMapActivity: NSObject, MapboxMapActivity {


    var geojsonDataSource: MGLGeoJSONSource = MGLGeoJSONSource(identifier: "layer-source", features: [MGLFeature](), options: nil)
    var newStyle: MGLLineStyleLayer? = nil
    
    func update(mapView: MGLMapView) {
        mapView.delegate = self
        mapView.styleURL = MGLStyle.darkStyleURL(withVersion: 9)
        mapView.setCenter(CLLocationCoordinate2DMake(40.669957, -98.591796), zoomLevel: 2, animated: false)
    }
    
    // MARK: MGLMapViewDelegate
    
    func mapViewDidFinishLoadingMap(_ mapView: MGLMapView) {
        let source = MGLSource(identifier: "source")!

        let symbolLayer = MGLSymbolStyleLayer(identifier: "place-city-sm", source: source)
        let url = URL(string: "https://www.mapbox.com/mapbox-gl-js/assets/earthquakes.geojson")!
        let options = [MGLGeoJSONSourceOption.clustered: NSNumber(booleanLiteral: true),
                       MGLGeoJSONSourceOption.clusterRadius: NSNumber(integerLiteral: 20),
                       MGLGeoJSONSourceOption.maximumZoomLevel: NSNumber(integerLiteral: 15)]
        let geoJSONSource = MGLGeoJSONSource(identifier: "earthquakes", url: url, options: options)
        mapView.style().add(geoJSONSource)

        let unclusteredLayer = MGLCircleStyleLayer(identifier: "unclustered", source: geoJSONSource)
        unclusteredLayer.circleColor = MGLStyleConstantValue(rawValue: UIColor(colorLiteralRed: 229/255.0, green: 94/255.0, blue: 94/255.0, alpha: 1))
        unclusteredLayer.circleRadius = MGLStyleConstantValue(rawValue: NSNumber(integerLiteral: 20))
        unclusteredLayer.circleBlur = MGLStyleConstantValue(rawValue: NSNumber(integerLiteral: 15))
        unclusteredLayer.predicate = NSPredicate(format: "%K != YES", argumentArray: ["cluster"])
        mapView.style().insert(unclusteredLayer, below: symbolLayer)

        let layers = [[NSNumber(floatLiteral: 150.0), UIColor(colorLiteralRed: 229/255.0, green: 94/255.0, blue: 94/255.0, alpha: 1)],
                      [NSNumber(floatLiteral: 20.0), UIColor(colorLiteralRed: 249/255.0, green: 136/255.0, blue: 108/255.0, alpha: 1)],
                      [NSNumber(floatLiteral: 0.0), UIColor(colorLiteralRed: 251/255.0, green: 176/255.0, blue: 59/255.0, alpha: 1)]]

        for index in 0..<layers.count {
            let circles = MGLCircleStyleLayer(identifier: "cluster-\(index)", source: geoJSONSource)
            circles.circleColor = MGLStyleConstantValue(rawValue: layers[index][1] as! UIColor)
            circles.circleRadius = MGLStyleConstantValue(rawValue: NSNumber(integerLiteral: 70))
            circles.circleBlur = MGLStyleConstantValue(rawValue: NSNumber(integerLiteral: 1))

            let gtePredicate = NSPredicate(format: "%K >= %@", argumentArray: ["point_count", layers[index][0] as! NSNumber])
            let allPredicate = index == 0 ?
                gtePredicate :
                NSCompoundPredicate(andPredicateWithSubpredicates: [gtePredicate, NSPredicate(format: "%K < %@", argumentArray: ["point_count", layers[index - 1][0] as! NSNumber])])

            circles.predicate = allPredicate

            mapView.style().insert(circles, below: symbolLayer)
        }
    }

}
