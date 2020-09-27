//
//  CharacterListWireframe.swift
//  marvel
//
//  Created by David Garcia on 20/09/2020.
//

import UIKit

class CharacterListWireframe: CharacterListWireframeInterface {
    
    static func createModule(_ view: UIViewController? = nil) -> UIViewController {

        if let view = view {
            return view
        }
        
        guard let view = R.storyboard.characterList()
                .instantiateViewController(identifier: "\(CharacterListViewController.self)") as? CharacterListViewController
        else { return UIViewController() }
        
        let marvelSource = MarvelDataSource(marvelAPI: marvelAPI)
        let interactor = CharacterListInteractor(source: marvelSource)
        let wireframe = CharacterListWireframe(view: view)
        let presenter = CharacterListPresenter(interactor: interactor,
                                               wireframe: wireframe)
        view.presenter = presenter
        
        let navigation = UINavigationController(rootViewController: view)
        
        return navigation
    }
    
    private unowned var _view: UIViewController!
    private var _navigationController: UINavigationController? {
        get {
            return _view.navigationController
        }
    }
    
    init(view: UIViewController) {
        _view = view
    }
    
    func goToDetails(character: CharacterData) {
        let externalWireframe = DetailWireframe.createModule(character: character)
        _navigationController?.pushViewController(externalWireframe, animated: true)
    }
}
