//
//  CharacterListInteractor.swift
//  marvel
//
//  Created by David Garcia on 20/09/2020.
//

import Foundation

class CharacterListInteractor: CharacterListInteractorInterface {
    private let _source: MarvelDataSourceInterface
    
    init(source: MarvelDataSourceInterface) {
        _source = source
    }
    
    func loadData(limit: Int, offset: Int, handler: @escaping (Result<CharacterInfo, Error>) -> Void) {
        _source.getCharacters(limit: limit, offset: offset) { result in
            switch result {
            case .success(let info):
                handler(.success(info))
            case .failure(let error):
                handler(.failure(error))
            }
        }
    }
    
    
}
