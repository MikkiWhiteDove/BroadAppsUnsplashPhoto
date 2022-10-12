//
//  DescriptionItem.swift
//  BroadAppsUnsplash
//
//  Created by Mishana on 11.10.2022.
//

import UIKit
import SDWebImage
import CoreData

class DescriptionItem: UIViewController{
    
    private var image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    
    var orderButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var downloadLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var likesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var locationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var addBarButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(image: UIImage(systemName: "heart"), style: .done, target: self, action: #selector(addBarButtonTapped))
    }()
    
    
    var loadData: ItemDescription! {
        didSet{
            let imageUrl = loadData.urls.regular
            let url = URL(string: imageUrl)

            image.sd_setImage(with: url)
        }
    }
    
    var loadDescription: LikeImage! {
        didSet{
            let imageUrl = loadDescription.url!
            let url = URL(string: imageUrl)

            image.sd_setImage(with: url)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(image)
        view.addSubview(orderButton)
        view.addSubview(downloadLabel)
        view.addSubview(likesLabel)
        view.addSubview(locationLabel)
        addConstraint()
    }
    
    func add(like: Bool){
        orderButton.isHidden = like
        orderButton.setTitle("Like Photo", for: .normal)
        orderButton.backgroundColor = .red
        orderButton.addTarget(self, action: #selector(addBarButtonTapped), for: .touchUpInside)
    }
    
    
    
    @objc private func addBarButtonTapped() {
        
        orderButton.backgroundColor = .gray
        orderButton.isHidden = true
        orderButton.setTitle("Like", for: .disabled)
        save()
    }
    
    private func save(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: "LikeImage", in: context) else {return}
        
        let object = LikeImage(entity: entity, insertInto: context)
        
        object.id = loadData.id
        object.name = loadData.user.name
        object.url = loadData.urls.regular
        object.smallUrl = loadData.urls.small
        object.downloads = Int64(loadData.downloads)
        object.country = loadData.location.country
        object.created = loadData.createdAt
        object.like = true
        
        do{
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
}

extension DescriptionItem {
    func addConstraint(){
        orderButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5).isActive = true
        orderButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        orderButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        orderButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        image.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        image.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        image.heightAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        image.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        downloadLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 10).isActive  = true
        downloadLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        
        likesLabel.topAnchor.constraint(equalTo: downloadLabel.bottomAnchor, constant: 5).isActive  = true
        likesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        
        locationLabel.topAnchor.constraint(equalTo: likesLabel.bottomAnchor, constant: 5).isActive  = true
        locationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
    }
}
