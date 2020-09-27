//
//  UIImage+URLString.swift
//  marvel
//
//  Created by David Garcia on 27/09/2020.
//

import UIKit

extension UIImageView {
    var imageUrl : String {
        get {
            return self.image?.accessibilityIdentifier ?? ""
        }
        set {
            guard let url = URL(string: newValue),
                  let data = try? Data(contentsOf: url),
                  let image = UIImage(data: data) else { return }
            
            self.image = image
        }
    }
}
