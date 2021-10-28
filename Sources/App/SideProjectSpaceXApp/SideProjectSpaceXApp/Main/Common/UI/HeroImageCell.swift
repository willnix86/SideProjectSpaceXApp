//
//  HeroImageCell.swift
//  SideProjectSpaceXApp
//
//  Created by Will Nixon on 10/26/21.
//

import UIKit

class HeroImageCell: UICollectionViewCell {
    static let reuseIdentifier = "hero-image-cell-reuse-identifier"
    let photoView = UIImageView()
    let contentContainer = UIView()

    var photo: UIImage? {
      didSet {
        configure()
      }
    }

    override init(frame: CGRect) {
      super.init(frame: frame)
      configure()
    }

    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
  }

  extension HeroImageCell {
    func configure() {
      contentContainer.translatesAutoresizingMaskIntoConstraints = false

      contentView.addSubview(photoView)
      contentView.addSubview(contentContainer)

      photoView.translatesAutoresizingMaskIntoConstraints = false
      if let photo = photo {
        photoView.image = photo
      }
      photoView.clipsToBounds = true
      contentContainer.addSubview(photoView)

      NSLayoutConstraint.activate([
        contentContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
        contentContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        contentContainer.topAnchor.constraint(equalTo: contentView.topAnchor),
        contentContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

        photoView.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor),
        photoView.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor),
        photoView.topAnchor.constraint(equalTo: contentContainer.topAnchor),
        photoView.bottomAnchor.constraint(equalTo: contentContainer.bottomAnchor)
      ])
    }
  }

