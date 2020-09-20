//
//  MarvelDataSource.swift
//  marvel
//
//  Created by David Garcia on 20/09/2020.
//

import Moya
import RxSwift

class MarvelDataSource {
    private let _marvelAPI: MoyaProvider<MarvelAPI>
    
    init(marvelAPI: MoyaProvider<MarvelAPI>) {
        _marvelAPI = marvelAPI
    }
    
    func getCharacters(limit: Int, offset: Int, completionHandler: @escaping (Result<CharacterInfo, MoyaError>) -> Void) {
        _marvelAPI.request(.getCaracters(10, 0)) { result in
            switch result{
            case .success(let response):
                do {
                    let json = try response.mapString().data(using: .utf8)!
                    let characterInfo = try! JSONDecoder().decode(CharacterInfo.self, from: json)
                    completionHandler(.success(characterInfo))
                } catch {
                    completionHandler(.failure(.jsonMapping(response)))
                }
                break
            case .failure(let error):
                completionHandler(.failure(error))
                break
            }
        }
    }
}
