import Mapbox

class HeatMapActivity: NSObject, MapboxMapActivity {
    
    func update(mapView: MGLMapView) {
        mapView.delegate = self
        mapView.styleURL = MGLStyle.darkStyleURL(withVersion: 9)
        mapView.setCenter(CLLocationCoordinate2DMake(40.669957, -98.591796), zoomLevel: 2, animated: false)
    }
    
    // MARK: MGLMapViewDelegate
    
    func mapViewDidFinishLoadingMap(_ mapView: MGLMapView) {
        let source = MGLSource(sourceIdentifier: "source")!
        
        let symbolLayer = MGLSymbolStyleLayer(layerIdentifier: "place-city-sm", source: source)
        let url = URL(string: "https://www.mapbox.com/mapbox-gl-js/assets/earthquakes.geojson")!
        let options = [MGLGeoJSONClusterOption: NSNumber(booleanLiteral: true),
                       MGLGeoJSONClusterRadiusOption: NSNumber(integerLiteral: 20),
                       MGLGeoJSONClusterMaximumZoomLevelOption: NSNumber(integerLiteral: 15)]
        let geoJSONSource = MGLGeoJSONSource(sourceIdentifier: "earthquakes", url: url, options: options)
        mapView.style().add(geoJSONSource)
        
        let unclusteredLayer = MGLCircleStyleLayer(layerIdentifier: "unclustered", source: geoJSONSource)
        unclusteredLayer.circleColor = UIColor(colorLiteralRed: 229/255.0, green: 94/255.0, blue: 94/255.0, alpha: 1)
        unclusteredLayer.circleRadius = NSNumber(integerLiteral: 20)
        unclusteredLayer.circleBlur = NSNumber(integerLiteral: 15)
        unclusteredLayer.predicate = NSPredicate(format: "%K != YES", argumentArray: ["cluster"])
        mapView.style().insert(unclusteredLayer, below: symbolLayer)
        
        let layers = [[NSNumber(floatLiteral: 150.0), UIColor(colorLiteralRed: 229/255.0, green: 94/255.0, blue: 94/255.0, alpha: 1)],
                      [NSNumber(floatLiteral: 20.0), UIColor(colorLiteralRed: 249/255.0, green: 136/255.0, blue: 108/255.0, alpha: 1)],
                      [NSNumber(floatLiteral: 0.0), UIColor(colorLiteralRed: 251/255.0, green: 176/255.0, blue: 59/255.0, alpha: 1)]]
        
        for index in 0..<layers.count {
            let circles = MGLCircleStyleLayer(layerIdentifier: "cluster-\(index)", source: geoJSONSource)
            circles.circleColor = layers[index][1] as! UIColor
            circles.circleRadius = NSNumber(integerLiteral: 70)
            circles.circleBlur = NSNumber(integerLiteral: 1)
            
            let gtePredicate = NSPredicate(format: "%K >= %@", argumentArray: ["point_count", layers[index][0] as! NSNumber])
            let allPredicate = index == 0 ?
                gtePredicate :
                NSCompoundPredicate(andPredicateWithSubpredicates: [gtePredicate, NSPredicate(format: "%K < %@", argumentArray: ["point_count", layers[index - 1][0] as! NSNumber])])
            
            circles.predicate = allPredicate
            
            mapView.style().insert(circles, below: symbolLayer)
        }
    }

}
