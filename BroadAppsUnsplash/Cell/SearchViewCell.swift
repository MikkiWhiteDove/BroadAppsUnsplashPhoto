//
//  SearchViewCell.swift
//  BroadAppsUnsplash
//
//  Created by Mishana on 10.10.2022.
//

import UIKit
import SDWebImage

class SearchViewCell: UICollectionViewCell {
    
    static let identifier = "SearchCollectionCell"
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .lightGray
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    var loadImage: Images! {
        didSet{
            let imageUrl = loadImage.urls.regular
            let url = URL(string: imageUrl)
            
            imageView.sd_setImage(with: url)
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImage()
    }
    
    private func setupImage() {
        addSubview(imageView)
        addConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse(){
        super.prepareForReuse()
        imageView.image = nil
    }
    
}

extension SearchViewCell {
    func addConstraint(){
        imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
}
