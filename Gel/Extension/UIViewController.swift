//
//  UIViewController.swift
//  Gel
//
//  Created by Admin on 3.02.2019.
//  Copyright © 2019 furrki. All rights reserved.
//

import Foundation
import UIKit
import SafariServices

extension UIViewController {
    func presentSFSafariVCFor(url: String){
        let readmeUrl = URL(string: url + readmeSegment)
        let safariVC = SFSafariViewController(url: readmeUrl!)
        present(safariVC, animated: true, completion: nil)
    }
}
