import Mapbox

class StyleVectorSourceLayer: NSObject, MapboxMapActivity {
    
    func update(mapView: MGLMapView) {
        mapView.delegate = self
        mapView.styleURL = MGLStyle.lightStyleURL(withVersion: 9)        
        mapView.setCenter(CLLocationCoordinate2DMake(37.7540113, -122.4484512), zoomLevel: 15, animated: false)
    }
    
    // MARK: MGLMapViewDelegate
    
    func mapViewDidFinishLoadingMap(_ mapView: MGLMapView) {

        let url = URL(string: "mapbox://mapbox.mapbox-terrain-v2")!
        let vectorSource = MGLVectorSource(identifier: "terrain-data", url: url)

        // add the vector source
        mapView.style().add(vectorSource)

        let lineLayer = MGLLineStyleLayer(identifier: "terrain-data", source: vectorSource)
        lineLayer.sourceLayerIdentifier = "contour"
        lineLayer.lineColor = MGLStyleConstantValue(rawValue: .red)
        lineLayer.lineJoin = MGLStyleValue(rawValue: NSValue(mglLineJoin: .round))
        mapView.style().add(lineLayer)

    }

}
