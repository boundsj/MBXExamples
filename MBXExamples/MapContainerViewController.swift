import UIKit
import Mapbox

class MapContainerViewController: UIViewController {
    
    @IBOutlet weak var mapView: MGLMapView!
    
    var example: Example?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = example?.title
        
        if let example = example {
            example.activity.update(mapView: mapView)
        }
    }    

}
