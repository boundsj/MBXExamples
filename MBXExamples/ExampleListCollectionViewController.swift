import UIKit

class ExampleListCollectionViewController: UICollectionViewController {

    private let exampleCellIdentifier = "exampleCellIdentifier"
    
    var examples: [Example]?
    var highlightedExample: Example?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        useLayoutToLayoutNavigationTransitions = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is MapContainerViewController {
            let mapContainerViewController = segue.destination as! MapContainerViewController
            mapContainerViewController.example = highlightedExample
        }
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let examples = examples else {
            return 0
        }
        
        return examples.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: exampleCellIdentifier, for: indexPath) as! ExampleCollectionViewCell
        guard let examples = examples else {
            return cell
        }
        
        let example = examples[indexPath.item]
        cell.titleLabel.text = example.title
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        guard let examples = examples else {
            return
        }
        
        highlightedExample = examples[indexPath.item]
    }

}

extension ExampleListCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return insets
    }
    
}
