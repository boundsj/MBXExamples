import Mapbox

class CustomAnnotationView: MGLAnnotationView {

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .red
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//    }
}
