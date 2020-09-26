//
//  DetailProtocol.swift
//  marvel
//
//  Created by David Garcia on 26/09/2020.
//

import UIKit

protocol DetailViewInterface {
    var presenter: DetailPresenterInterface? { get set }
}

protocol DetailPresenterInterface {
    var character: CharacterData { get }
}

protocol DetailWireframeInterface {
    static func createModule(_ view: UIViewController?, character: CharacterData) -> UIViewController
}
