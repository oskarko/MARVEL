//
//  CharacterCell.swift
//  Marvel
//
//  Created by Oscar Rodriguez Garrucho on 7/12/20.
//  Copyright © 2020 Little Monster. All rights reserved.
//

import SDWebImage
import UIKit

class CharacterCell: UICollectionViewCell {

    // MARK: - Properties

    var character: Character? {
        didSet { configure() }
    }

    private let characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .lightGray

        return imageView
    }()

    let characterNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)

        return label
    }()

    // MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(characterImageView)
        characterImageView.anchor(top: topAnchor,
                                  left: leftAnchor,
                                  right: rightAnchor,
                                  paddingTop: 4,
                                  paddingLeft: 4,
                                  paddingRight: 4)
        characterImageView.layer.cornerRadius = 4

        addSubview(characterNameLabel)
        characterNameLabel.anchor(top: characterImageView.bottomAnchor,
                                  left: leftAnchor,
                                  bottom: bottomAnchor,
                                  right: rightAnchor,
                                  paddingTop: 2,
                                  paddingLeft: 4,
                                  paddingBottom: 4,
                                  paddingRight: 4)
        characterNameLabel.setDimensions(height: 24)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Helpers

    private func configure() {
        guard let character = character else { return }

        characterNameLabel.text = character.name

        guard let path = character.thumbnail?.path,
              let fileExtension = character.thumbnail?.fileExtension?.description,
              let url = URL(string: path + "." + fileExtension),
              !path.contains("image_not_available") else {

            characterImageView.image = UIImage(named: "imageNotAvailable")
            return
        }

        characterImageView.sd_setImage(with: url, completed: nil)
    }
}
