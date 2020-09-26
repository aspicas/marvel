//
//  DetailPresenter.swift
//  marvel
//
//  Created by David Garcia on 26/09/2020.
//

import Foundation

class DetailPresenter: DetailPresenterInterface {
    
    var character: CharacterData {
        get { return _character }
    }
    
    private var _character: CharacterData
    
    init(character: CharacterData) {
        _character = character
    }
    
}
