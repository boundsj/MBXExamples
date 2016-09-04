import Mapbox

class SetStyleActivity: NSObject, MapboxMapActivity {
    
    var mapView: MGLMapView!
    
    func update(mapView: MGLMapView) {
        self.mapView = mapView
        
        // center the map on Paris, France and zoom in a bit
        mapView.setCenter(CLLocationCoordinate2DMake(48.864716, 2.349014), zoomLevel: 11, animated: false)
        
        // add some controls to allow us to tell the map what style we want to use
        addControls()
    }
    
    func addControls() {
        let segmentedControl = UISegmentedControl(items: ["St", "Outdrs", "Lght", "Drk", "Sat", "Sat. St"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.backgroundColor = UIColor.white
        segmentedControl.addTarget(self, action: #selector(SetStyleActivity.didTap(segmentedControl:)), for: .valueChanged)
        let font = UIFont.boldSystemFont(ofSize: 8)
        let attributes = [NSFontAttributeName: font]
        segmentedControl.setTitleTextAttributes(attributes, for: .normal)
        segmentedControl.apportionsSegmentWidthsByContent = true
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        mapView.superview?.insertSubview(segmentedControl, aboveSubview: mapView)
        
        if let superView = mapView.superview {
            segmentedControl.centerXAnchor.constraint(equalTo: superView.centerXAnchor).isActive = true
            segmentedControl.topAnchor.constraint(equalTo: superView.topAnchor, constant: 68).isActive = true
            segmentedControl.widthAnchor.constraint(equalToConstant: 200)
        }        
    }
    
    func didTap(segmentedControl: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            mapView.styleURL = MGLStyle.streetsStyleURL(withVersion: 9)
        case 1:
            mapView.styleURL = MGLStyle.outdoorsStyleURL(withVersion: 9)
        case 2:
            mapView.styleURL = MGLStyle.lightStyleURL(withVersion: 9)
        case 3:
            mapView.styleURL = MGLStyle.darkStyleURL(withVersion: 9)
        case 4:
            mapView.styleURL = MGLStyle.satelliteStyleURL(withVersion: 9)
        case 5:
            mapView.styleURL = MGLStyle.satelliteStreetsStyleURL(withVersion: 9)
        default:
            mapView.styleURL = MGLStyle.streetsStyleURL(withVersion: 9)
        }
    }
    
}
