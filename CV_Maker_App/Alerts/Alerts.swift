//
//  Alerts.swift
//  CV_Maker_App
//
//  Created by Dmitriy Mkrtumyan on 27.07.23.
//

import Foundation
import UIKit

final class Alerts {
    static func emptyTextFieldAlert(vc: UIViewController) {
        let alertController = UIAlertController(title: "Not enough data", message: "Please fill in the forms", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .cancel)
        alertController.addAction(alertAction)
        vc.present(alertController, animated: true)
    }
}
