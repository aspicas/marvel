//
//  String+Md5.swift
//  marvel
//
//  Created by David Garcia on 20/09/2020.
//

import CryptoKit
import Foundation

extension String {
    var md5: String {
        return Insecure.MD5
            .hash(data: self.data(using: .utf8) ?? Data())
            .map {
                String(format: "%02hhx", $0)
            }.joined()
    }
}
