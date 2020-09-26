//
//  CharacterCollectionViewCell.swift
//  marvel
//
//  Created by David Garcia on 21/09/2020.
//

import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    
    var imageUrl : String {
        get {
            return imageView.image?.accessibilityIdentifier ?? ""
        }
        set {
            guard let url = URL(string: newValue),
                  let data = try? Data(contentsOf: url),
                  let image = UIImage(data: data) else { return }
            
            imageView.image = image
        }
    }
    
    var name: String {
        get {
            return nameLabel.text ?? ""
        }
        set {
            nameLabel.text = newValue
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        settingCell()
    }
    
    private func settingCell() {
        self.layer.cornerRadius = 20
        self.layer.masksToBounds = true
        self.nameLabel.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.nameLabel.layer.shadowOpacity = 0.8
        self.nameLabel.layer.shadowRadius = 2
        self.nameLabel.shadowColor = UIColor(red: 113, green: 1, blue: 23, alpha: 1)
    }

}
