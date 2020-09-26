//
//  CharacterListPresenter.swift
//  marvel
//
//  Created by David Garcia on 20/09/2020.
//

import Foundation
import RxCocoa
import RxSwift

class CharacterListPresenter: CharacterListPresenterInterface {
    
    private let _viewRelay: BehaviorRelay<CharacterDataState>
    private let _interactor: CharacterListInteractorInterface
    private let _wireframe: CharacterListWireframeInterface
    private let disposeBag = DisposeBag()
    private let limit: Int = 20
    private var offset: Int = 0
    private var count: Int = 20
    
    var viewSource: Driver<CharacterDataState>
    
    init(interactor: CharacterListInteractorInterface, wireframe: CharacterListWireframeInterface) {
        _interactor = interactor
        _wireframe = wireframe
        _viewRelay = BehaviorRelay(value: .empty)
        
        viewSource = _viewRelay.asDriver()
    }
    
    func getCharacterData() {
        
        guard limit == count else { return }
        
        _viewRelay.accept(.loading)
        _interactor.loadData(limit: limit, offset: offset) { result in
            switch result {
            case .success(let info):
                self.offset += self.limit
                self.count = info.data.count
                self._viewRelay.accept(.success(data: info.data.results))
            case .failure(let error):
                self._viewRelay.accept(.error(error: error))
            }
        }
    }
    
    func selectedCell(character: CharacterData) {
        _wireframe.goToDetails(character: character)
    }
    
    
}
