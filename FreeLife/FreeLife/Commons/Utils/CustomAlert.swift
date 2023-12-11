//
//  CustomAlert.swift
//  MyHobby
//
//  Created by ihan carlos on 09/11/23.
//

import UIKit

extension UIViewController {
    func customAlert(title: String, message: String, preferredStyle: UIAlertController.Style = .alert) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
