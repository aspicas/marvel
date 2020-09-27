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
            return imageView.imageUrl
        }
        set {
            imageView.imageUrl = newValue
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
        self.nameLabel.layer.shadowOffset = CGSize(width: 4, height: 4)
        self.nameLabel.layer.shadowOpacity = 0.7
        self.nameLabel.layer.shadowRadius = 2
        self.nameLabel.shadowColor = R.color.backgroundSecond()
    }

}
