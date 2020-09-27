//
//  MarvelDataSourceMock.swift
//  marvelTests
//
//  Created by David Garcia on 27/09/2020.
//

@testable import marvel
import UIKit

class MarvelDataSourceMock: BaseMocK, MarvelDataSourceInterface {
    
    enum SourceError: Error {
        case unexpectedError
    }
    
    enum SuccessState {
        case empty
        case full
    }
    
    var fakeSuccess = false
    var successState = SuccessState.empty
    
    func getCharacters(limit: Int, offset: Int, completionHandler: @escaping (Result<CharacterInfo, Error>) -> Void) {
        if fakeSuccess {
            completionHandler(.success(getSuccessData(state: successState)!))
        } else {
            completionHandler(.failure(SourceError.unexpectedError))
        }
    }
    
    private func getSuccessData(state: SuccessState) -> CharacterInfo? {
        do {
            let name = state == .full ? "SuccessCharacter" : "EmptyCharacter"
            let response = stubbedResponse(name)
            let info = try JSONDecoder().decode(CharacterInfo.self, from: response ?? Data())
            return info
        } catch {
            print("Error converting object")
        }
        return nil
    }
}
