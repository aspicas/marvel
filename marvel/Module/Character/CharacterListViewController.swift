//
//  CharacterListViewController.swift
//  marvel
//
//  Created by David Garcia on 20/09/2020.
//

import UIKit

class CharacterListViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    private var mock: [Int] = [1,2,3,4,5,6,7,8,9]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        registerCells()
    }
    
    private func registerCells() {
        collectionView.register(R.nib.characterCollectionViewCell)
    }

}

extension CharacterListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return mock.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: R.nib.characterCollectionViewCell.identifier,
            for: indexPath) as! CharacterCollectionViewCell
        
        cell.label.text = "\(mock[indexPath.row])"
        cell.backgroundColor = indexPath.row % 3 == 0 ? .cyan : .blue
        
        cell.contentView.layer.cornerRadius = 20
        cell.contentView.layer.masksToBounds = true
        
        cell.layer.cornerRadius = 20
        cell.layer.masksToBounds = true
        
        return cell
    }
}

extension CharacterListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowlayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowlayout?.minimumInteritemSpacing ?? 0.0) + (flowlayout?.sectionInset.left ?? 0.0) + (flowlayout?.sectionInset.right ?? 0.0)
        let size: CGFloat = (self.collectionView.frame.size.width - space) / 2.0
        return CGSize(width: size, height: size)
    }
}
