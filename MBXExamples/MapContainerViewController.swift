import UIKit

class MapContainerViewController: UIViewController {
    
    var example: Example?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = example?.title
    }

}
