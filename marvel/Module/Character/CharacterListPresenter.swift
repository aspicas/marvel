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
    private let _disposeBag = DisposeBag()
    private let _limit: Int = 20
    private var _offset: Int = 0
    private var _count: Int = 20
    
    var viewSource: Driver<CharacterDataState>
    
    init(interactor: CharacterListInteractorInterface, wireframe: CharacterListWireframeInterface) {
        _interactor = interactor
        _wireframe = wireframe
        _viewRelay = BehaviorRelay(value: .empty)
        
        viewSource = _viewRelay.asDriver()
    }
    
    func getCharacterData() {
        
        guard _limit == _count else { return }
        
        _viewRelay.accept(.loading)
        _interactor.loadData(limit: _limit, offset: _offset) { result in
            switch result {
            case .success(let info):
                self._offset += self._limit
                self._count = info.data.count
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
