//
//  CharacterListProtocol.swift
//  marvel
//
//  Created by David Garcia on 23/09/2020.
//

import RxCocoa

enum CharacterDataState {
    case empty
    case loading
    case success(data: [CharacterData])
    case error(error: Error)
}

protocol CharacterListViewInterface: class {
    var presenter: CharacterListPresenterInterface? { get set }
}

protocol CharacterListPresenterInterface: class {
    var viewSource: Driver<CharacterDataState> { get }

    func getCharacterData()
    func selectedCell(character: CharacterData)
}

protocol CharacterListInteractorInterface: class {
    func loadData(limit: Int, offset: Int, handler: @escaping (Result<CharacterInfo, Error>) -> Void)
}

protocol CharacterListWireframeInterface: class {
    static func createModule(_ view: UIViewController?) -> UIViewController
    func goToDetails()
}
