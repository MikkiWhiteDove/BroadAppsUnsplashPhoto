//
//  Alert.swift
//  BroadAppsUnsplash
//
//  Created by Mishana on 12.10.2022.
//

import Foundation
import UIKit

struct Alert {
    static func showAlertNoInternet(on vc: UIViewController, with title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in
            vc.dismiss(animated: true)
        }))
        DispatchQueue.main.async { vc.present(alert, animated: true) }
    }
    static func showAletrSearchControllerNoInternet(on vc: UIViewController, with title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        DispatchQueue.main.async { vc.present(alert, animated: true) }
    }
}
