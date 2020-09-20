//
//  MarvelDataSourceInterface.swift
//  marvel
//
//  Created by David Garcia on 20/09/2020.
//

import Foundation

protocol MarvelDataSourceInterface {
    func getCharacters(limit: Int, offset: Int, completionHandler: @escaping (Result<CharacterInfo, Error>) -> Void)
}
