//
//  LikeViewController.swift
//  BroadAppsUnsplash
//
//  Created by Mishana on 10.10.2022.
//

import UIKit
import CoreData

class LikeViewController: UIViewController {
    
    var likeNews = [LikeImage]()

    private var tableView = UITableView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<LikeImage> = LikeImage.fetchRequest()
        do{
            likeNews = try context.fetch(fetchRequest)
        } catch let error as NSError{
            print(error.localizedDescription)
        }
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Likes"
        addTable()
    }
    
    func addTable() {
        view.addSubview(tableView)
        tableView.pin(to: view)
        tableView.rowHeight = 100
        tableView.register(LikeViewCell.self, forCellReuseIdentifier: LikeViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension LikeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let deleteIndex = indexPath.row
        let moreDescription = likeNews[indexPath.row]
        let vc = DescriptionItem()
        
        vc.add(like: true)
        vc.loadDescription = moreDescription
        vc.title = moreDescription.name
        vc.downloadLabel.text = "Downloads: \(moreDescription.downloads)"
       
        let date = DateFormatter()
        date.locale = Locale(identifier: "en_US_POSIX")
        date.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let dateFor = date.date(from: moreDescription.created ?? "")!
        vc.likesLabel.text = "Create: \(dateFor)"
        
        if let location = moreDescription.country{
            vc.locationLabel.text = "Location: \(location)"
        }
        
        let nav = UINavigationController(rootViewController: vc)
        nav.navigationBar.prefersLargeTitles = true
        if let sheet = nav.sheetPresentationController{
            sheet.detents = [.large()]
        }
        present(nav, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest: NSFetchRequest<LikeImage> = LikeImage.fetchRequest()
//
            context.delete(likeNews[indexPath.row])
            likeNews.remove(at: indexPath.row)
            do {
                try context.save()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return likeNews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LikeViewCell.identifier, for: indexPath) as! LikeViewCell
        
        let like = likeNews[indexPath.row]
        let url = like.smallUrl ?? ""
        let label = like.name ?? ""
        cell.config(logo: url, label: label)
        return cell
    }
}
