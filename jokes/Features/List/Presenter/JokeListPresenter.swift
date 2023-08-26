//
//  JokeListPresenter.swift
//  jokes
//
//  Created by ShrishMishra on 26/08/23.
//

import Foundation
import UIKit
final class JokeListPresenter {
    var jokeArray: [String] = []{
        didSet {
            updateUI?()
        }
    }
    fileprivate unowned var view: JokeListProtocol
    var updateUI: (() -> Void)?
    init(view: JokeListProtocol) {
        self.view = view
        fetchSavedJokes()
        startTimer()
        fetchSavedJokes()

    }
}

// MARK: - Public methods
extension JokeListPresenter {
    
    func loadData() {
        NetworkManager.shared.fetchJokeData{ [weak self] result in
            switch result {
            case .success(let joke):
                 self?.addJoke(joke)
            case .failure(let error):
                self?.requestError(description: "error \(error)")
            }
        }
    }
}

extension JokeListPresenter {
    
    func addJoke(_ joke: String) {
        JokeCoreData.shared.saveJokes(joke)
        fetchSavedJokes()
    }

    private func fetchSavedJokes() {
        let storedJokes = JokeCoreData.shared.fetchJokes(limit: 10)
        jokeArray = storedJokes.map { $0.title ?? ""}
        self.view.reloadTableView()
    }
}
// MARK: - Private methods
extension JokeListPresenter {
    
    private func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { [weak self] _ in
             self?.loadData()
        }.fire()
    }
    
    fileprivate func requestError(description: String) {
        DispatchQueue.main.async {
            self.view.showAlertError(title: "Error", message: description, buttonTitle: "OK")
        }
    }
}
