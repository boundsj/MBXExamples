import UIKit
import Mapbox

class MapContainerViewController: UIViewController {
    
    @IBOutlet weak var mapView: MGLMapView!
    
    var example: Example?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = example?.title
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let example = example {
            example.activity.update(mapView: mapView)
        }
    }

}
