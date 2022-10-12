//
//  LikeViewCell.swift
//  BroadAppsUnsplash
//
//  Created by Mishana on 12.10.2022.
//

import UIKit
import SDWebImage

class LikeViewCell: UITableViewCell {

    static let identifier = "LikeViewCell"
    
    let myImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.isUserInteractionEnabled = true
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 20
        image.clipsToBounds = true
        return image
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true
        label.font = .systemFont(ofSize: 19)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(myImageView)
        addSubview(descriptionLabel)
        addConstraint()
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse(){
        super.prepareForReuse()
        myImageView.image = nil
    }
    
    func config(logo: String, label: String){
        self.myImageView.sd_setImage(with: URL(string:logo))
        self.descriptionLabel.text = label
    }
    
}
extension LikeViewCell {
    func addConstraint() {
        myImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        myImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        myImageView.heightAnchor.constraint(equalToConstant: 90).isActive = true
        myImageView.widthAnchor.constraint(equalToConstant: 90).isActive = true
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: myImageView.trailingAnchor, constant: 20).isActive = true
        descriptionLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
    }
}
