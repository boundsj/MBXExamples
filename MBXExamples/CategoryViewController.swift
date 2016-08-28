import UIKit

class CategoryViewController: UICollectionViewController {
    
    let categoryCellIdentifier = "categoryCellIdentifier"
    let screenSize = UIScreen.main.bounds
    var highlightedExamples: [Example]?
    
    // MARK: UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.delegate = self
        collectionView?.delegate = self
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
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
        } else if viewController == self {
            collectionView?.delegate = self
            collectionView?.dataSource = self
        }
    }
    
}

extension CategoryViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: screenSize.width - 16, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 8, bottom: 10, right: 8)
    }
    
}
