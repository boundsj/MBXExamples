import Mapbox

class DraggableCustomAnnotationActivity: NSObject, MapboxMapActivity {
    
    func update(mapView: MGLMapView) {
        mapView.delegate = self
        mapView.setCenter(CLLocationCoordinate2DMake(40.669957, -98.591796), zoomLevel: 10, animated: false)
        
        let annotation = MGLPointAnnotation()
        annotation.coordinate = mapView.centerCoordinate
        mapView.addAnnotation(annotation)
    }

}

extension DraggableCustomAnnotationActivity: MGLMapViewDelegate {
    
    func mapView(_ mapView: MGLMapView, viewFor annotation: MGLAnnotation) -> MGLAnnotationView? {
        let reuseIdentifier = "annotation-view-reuse-identifier"
        var view = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
        if view == nil {
            view = CustomAnnotationView(reuseIdentifier: reuseIdentifier)
//            view?.backgroundColor = .blue
            view?.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
            view?.isDraggable = true
        }
        return view
    }
    
}


