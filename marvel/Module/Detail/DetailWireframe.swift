//
//  DetailWireframe.swift
//  marvel
//
//  Created by David Garcia on 26/09/2020.
//

import UIKit

class DetailWireframe: DetailWireframeInterface {
    static func createModule(_ view: UIViewController? = nil, character: CharacterData) -> UIViewController {
        guard let view = view else { return createDefaultModule(character: character) }
        
        return view
    }
    
    fileprivate static func createDefaultModule(character: CharacterData) -> UIViewController {
        
        guard let view = R.storyboard.detail().instantiateViewController(identifier: "\(DetailViewController.self)") as? DetailViewController
        else { return UIViewController() }

        let presenter = DetailPresenter(character: character)
        view.presenter = presenter
        
        return view
    }
    
}
