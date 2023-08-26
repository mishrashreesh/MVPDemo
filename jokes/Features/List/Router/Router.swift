//
//  Router.swift
//  jokes
//
//  Created by ShrishMishra on 26/08/23.
//

import Foundation
import UIKit
final class Router {
    class func present(at window: UIWindow?) {
        let controller = ViewController()
        let navigation = UINavigationController(rootViewController: controller)
        window?.rootViewController = navigation
    }
}
