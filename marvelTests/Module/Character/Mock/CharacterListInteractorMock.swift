//
//  File.swift
//  marvelTests
//
//  Created by David Garcia on 26/09/2020.
//

@testable import marvel
import UIKit

class CharacterListInteractorMock: BaseMocK, CharacterListInteractorInterface {
    enum InteractorError: Error {
        case unexpectedError
    }
    
    enum SuccessState {
        case empty
        case full
    }
    
    var fakeSuccess = false
    var successState = SuccessState.empty
    
    func loadData(limit: Int, offset: Int, handler: @escaping (Result<CharacterInfo, Error>) -> Void) {
        if fakeSuccess {
            handler(.success(getSuccessData(state: self.successState)!))
        } else {
            handler(.failure(InteractorError.unexpectedError))
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
