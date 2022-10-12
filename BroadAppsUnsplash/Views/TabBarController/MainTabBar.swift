//
//  MainTabBar.swift
//  BroadAppsUnsplash
//
//  Created by Mishana on 10.10.2022.
//

import UIKit

class MainTabBar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        let vc1 = SearchViewController()
    
        let vc2 = LikeViewController()
        
        tabBar.tintColor = .label
        
        setViewControllers([
            generateViewController(rootViewController: vc1, image: "magnifyingglass", title: "Search"),
        generateViewController(rootViewController: vc2, image: "heart", title: "Likes")], animated: true)
    }
    
    private func generateViewController(rootViewController: UIViewController, image: String, title: String)-> UIViewController{
        let navVC = UINavigationController(rootViewController: rootViewController)
        navVC.tabBarItem.title = title
        navVC.tabBarItem.image = UIImage(systemName: image)
        
        return navVC
    }
}
