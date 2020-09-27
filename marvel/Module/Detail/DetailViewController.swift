//
//  DetailViewController.swift
//  marvel
//
//  Created by David Garcia on 26/09/2020.
//

import UIKit

class DetailViewController: UIViewController, DetailViewInterface {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var presenter: DetailPresenterInterface?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setScreenData(character: presenter?.character)
    }
    
    private func setScreenData(character: CharacterData?) {
        guard let character = character else { return }
        navigationItem.title = character.name
        navigationController?.navigationBar.barTintColor = R.color.letterSecond()
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: R.color.letterPrimary()!]
        navigationController?.navigationBar.tintColor = R.color.letterPrimary()
        imageView.imageUrl = character.imageUrl
        descriptionLabel.text = character.resultDescription.isEmpty ? "No description" : character.resultDescription
    }
    
}
