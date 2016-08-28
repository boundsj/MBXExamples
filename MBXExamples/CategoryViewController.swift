import UIKit

class CategoryViewController: UICollectionViewController {
    
    private let categoryCellIdentifier = "categoryCellIdentifier"
    
    // MARK: UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.delegate = self
    }
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryCellIdentifier, for: indexPath)
        cell.backgroundColor = UIColor.blue
        return cell
    }

}

extension CategoryViewController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        if viewController is ExampleListCollectionViewController {
            let exampleListViewController = viewController as! ExampleListCollectionViewController
            exampleListViewController.collectionView?.delegate = exampleListViewController
            exampleListViewController.collectionView?.dataSource = exampleListViewController
        } else if viewController == self {
            collectionView?.delegate = self
            collectionView?.dataSource = self
        }
    }
    
}

