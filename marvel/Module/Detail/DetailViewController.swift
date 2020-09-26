//
//  DetailViewController.swift
//  marvel
//
//  Created by David Garcia on 26/09/2020.
//

import UIKit

class DetailViewController: UIViewController, DetailViewInterface {
    
    var presenter: DetailPresenterInterface?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setScreenData(character: presenter?.character)
    }
    
    private func setScreenData(character: CharacterData?) {
        guard let character = character else { return }
        
    }
    
}
