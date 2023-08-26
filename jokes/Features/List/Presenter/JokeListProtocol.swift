//
//  JokeListProtocol.swift
//  jokes
//
//  Created by ShrishMishra on 26/08/23.
//

import Foundation
protocol JokeListProtocol: class {
    func reloadTableView()
    func showAlertError(title: String, message: String, buttonTitle: String)
}
