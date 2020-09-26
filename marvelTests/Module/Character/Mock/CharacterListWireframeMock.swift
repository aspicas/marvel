//
//  CharacterListWireframeMock.swift
//  marvelTests
//
//  Created by David Garcia on 26/09/2020.
//

import UIKit
@testable import marvel

class CharacterListWireframeMock: BaseMocK, CharacterListWireframeInterface {
    
    static func createModule(_ view: UIViewController?) -> UIViewController {
        return UIViewController()
    }
    
    var characters: CharacterData {
        get { return getData()!}
    }
    
    private var _result = false
    var result: Bool {
        get { return _result }
        set { _result = newValue }
    }
    
    func goToDetails(character: CharacterData) {
        _result = true
    }
    
    private func getData() -> CharacterData? {
        do {
            let response = stubbedResponse("SuccessCharacter")
            let info = try JSONDecoder().decode(CharacterInfo.self, from: response ?? Data())
            return info.data.results[0]
        } catch {
            print("Error converting object")
        }
        return nil
    }
    
    
}
