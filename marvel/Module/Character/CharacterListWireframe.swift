//
//  CharacterListWireframe.swift
//  marvel
//
//  Created by David Garcia on 20/09/2020.
//

import UIKit

class CharacterListWireframe: CharacterListWireframeInterface {
    static func createModule(_ view: UIViewController?) -> UIViewController {
        
        guard let view = view else { return createModule() }
        
        return view
    }
    
    static func createModule() -> UIViewController {
        
        guard let view = R.storyboard.characterList().instantiateInitialViewController() as? CharacterListViewController
        else { return UIViewController() }
        
        let marvelSource = MarvelDataSource(marvelAPI: marvelAPI)
        let interactor = CharacterListInteractor(source: marvelSource)
        let wireframe = CharacterListWireframe(view: view)
        let presenter = CharacterListPresenter(interactor: interactor,
                                               wireframe: wireframe)
        view.presenter = presenter
        
        return view
    }
    
    private unowned var _view: UIViewController!
    private var navigationController: UINavigationController? {
        get {
            return _view.navigationController
        }
    }
    
    init(view: UIViewController) {
        _view = view
    }
    
    func goToDetails() {
        
    }
    
    
}
