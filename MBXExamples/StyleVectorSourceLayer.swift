import Mapbox

class StyleVectorSourceLayer: NSObject, MapboxMapActivity {
    
    func update(mapView: MGLMapView) {
        mapView.delegate = self
        mapView.styleURL = MGLStyle.lightStyleURL(withVersion: 9)        
        mapView.setCenter(CLLocationCoordinate2DMake(37.7540113, -122.4484512), zoomLevel: 15, animated: false)
    }
    
    // MARK: MGLMapViewDelegate
    
    func mapViewDidFinishLoadingMap(_ mapView: MGLMapView) {
        let url = URL(string: "mapbox://mapbox.mapbox-terrain-v2")
        
        if let vectorSource = MGLVectorSource(sourceIdentifier: "terrain-data", url: url) {
            // add the vector source
            mapView.style().add(vectorSource)
            
            let lineLayer = MGLLineStyleLayer(layerIdentifier: "terrain-data", source: vectorSource, sourceLayer: "contour")
            lineLayer.lineColor = UIColor.red
            
            var lineJoinValue = MGLLineStyleLayerLineJoin.round.rawValue
            let lineJoinNumber = NSNumber(value: lineJoinValue)
            lineLayer.lineJoin = NSValue(bytes: &lineJoinValue, objCType: lineJoinNumber.objCType)
            
            var lineCapValue = MGLLineStyleLayerLineCap.round.rawValue
            let lineCapNumber = NSNumber(value: lineCapValue)
            lineLayer.lineCap = NSValue(bytes: &lineCapValue, objCType: lineCapNumber.objCType)
            
            mapView.style().add(lineLayer)
        }
    }

}
