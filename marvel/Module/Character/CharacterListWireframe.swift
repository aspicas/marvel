//
//  CharacterListWireframe.swift
//  marvel
//
//  Created by David Garcia on 20/09/2020.
//

import UIKit

class CharacterListWireframe: CharacterListWireframeInterface {
    
    static func createModule(_ view: UIViewController? = nil) -> UIViewController {
        
        guard let view = view else { return createDefaultModule() }
        
        return view
    }
    
    fileprivate static func createDefaultModule() -> UIViewController {
        
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
