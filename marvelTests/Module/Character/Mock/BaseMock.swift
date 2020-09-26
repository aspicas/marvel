//
//  BaseMock.swift
//  marvelTests
//
//  Created by David Garcia on 26/09/2020.
//

import Foundation

class BaseMocK {
    internal func stubbedResponse(_ file: String?) -> Data! {
        let bundle = Bundle(for: type(of: self))
        if let bundlePath = bundle.path(forResource: file, ofType: "json"),
           let jsonData = try! String(contentsOfFile: bundlePath).data(using: .utf8) {
            return jsonData
        }
        return Data()
    }
}
