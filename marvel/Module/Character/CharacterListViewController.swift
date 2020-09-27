//
//  CharacterListViewController.swift
//  marvel
//
//  Created by David Garcia on 20/09/2020.
//

import UIKit
import RxSwift

class CharacterListViewController: UIViewController, CharacterListViewInterface {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    private var characters: [CharacterData] = []
    private let disposeBag = DisposeBag()
    
    var presenter: CharacterListPresenterInterface?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Marvel"
        navigationController?.navigationBar.barTintColor = R.color.letterSecond()
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: R.color.letterPrimary()!]
        collectionView.delegate = self
        collectionView.dataSource = self
        registerCells()
        presenter?.viewSource
            .debug("Character List Source")
            .drive(onNext: { [weak self] dataState in
                switch dataState {
                case .empty:
                    self?.deactiveIndicator()
                case .success(let data):
                    self?.addCharacter(data)
                    self?.deactiveIndicator()
                case .loading:
                    self?.activeIndicator()
                case .error(let error):
                    self?.show(error: error)
                    self?.deactiveIndicator()
                }
            }, onCompleted: {
                print("Completed")
            }).disposed(by: disposeBag)
        
        presenter?.getCharacterData()
    }
    
    private func registerCells() {
        collectionView.register(R.nib.characterCollectionViewCell)
    }
    
    private func addCharacter(_ data: [CharacterData]) {
        characters.append(contentsOf: data)
        let indexPath = IndexPath(row: characters.count - 1, section: 0)
        collectionView.insertItems(at: [indexPath])
    }
    
    private func show(error: Error) {
        let alertController = UIAlertController(title: "Something went wrong",
                                                message: error.localizedDescription,
                                                preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(cancelAction)
        
        let retryAction = UIAlertAction(title: "Retry", style: .default) { _ in
            self.presenter?.getCharacterData()
        }
        alertController.addAction(retryAction)
        
        present(alertController, animated: true)
    }
    
    private func activeIndicator() {
        activityIndicatorView.startAnimating()
        activityIndicatorView.isHidden = false
    }
    
    private func deactiveIndicator() {
        activityIndicatorView.stopAnimating()
        activityIndicatorView.isHidden = true
    }

}

extension CharacterListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: R.nib.characterCollectionViewCell.identifier,
            for: indexPath) as! CharacterCollectionViewCell

        let character = characters[indexPath.row]

        cell.name = character.name
        cell.imageUrl = character.imageUrl
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == characters.count - 4 {
            DispatchQueue.global(qos: .background).async {
                self.presenter?.getCharacterData()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.selectedCell(character: characters[indexPath.row])
    }
}

extension CharacterListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let spaceOccupedOnScreen:CGFloat = 0.4822
        let size: CGFloat = (self.collectionView.frame.size.width*spaceOccupedOnScreen)
        return CGSize(width: size, height: size)
    }
}
