import UIKit

class CategoryViewController: UICollectionViewController {
    
    let categoryCellIdentifier = "categoryCellIdentifier"
    var highlightedExamples: [Example]?
    var obsuringViewController: UIViewController?
    
    // MARK: UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.delegate = self
        collectionView?.delegate = self
        navigationItem.title = "Mapbox Dev Preview"
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let obsuringViewController = obsuringViewController {
            return obsuringViewController.prepare(for: segue, sender: sender)
        }

        if segue.destination is ExampleListCollectionViewController {
            let exampleListViewController = segue.destination as! ExampleListCollectionViewController
            exampleListViewController.examples = highlightedExamples
        } 
    }
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryCellIdentifier, for: indexPath) as! CategoryCollectionViewCell
        let category = categories[indexPath.item]
        cell.titleLabel.text = category.title        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        highlightedExamples = categories[indexPath.item].examples
    }

}

extension CategoryViewController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        if viewController is ExampleListCollectionViewController {
            let exampleListViewController = viewController as! ExampleListCollectionViewController
            exampleListViewController.collectionView?.delegate = exampleListViewController
            exampleListViewController.collectionView?.dataSource = exampleListViewController
            obsuringViewController = exampleListViewController
        } else if viewController == self {
            collectionView?.delegate = self
            collectionView?.dataSource = self
            obsuringViewController = nil
        }
    }
    
}

extension CategoryViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return insets
    }
    
}

