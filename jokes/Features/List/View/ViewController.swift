//
//  ViewController.swift
//  jokes
//
//  Created by ShrishMishra on 26/08/23.
//

import UIKit

final class ViewController: UIViewController {
    private let tableView = UITableView()
    private var shouldScrollToNewJoke = false
    
    var presenter: JokeListPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.loadJokes()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        guard let presenter = self.presenter else {
//            return 0
//        }
        return presenter?.jokeArray.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: JokeTableViewCell.reuseIdentifier, for: indexPath) as! JokeTableViewCell
//        guard let presenter = self.presenter else {
//            fatalError("Present can't be nil")
//        }
        let jokesModel = presenter?.jokeArray[indexPath.row]
        cell.configure(with : String(describing: jokesModel ?? ""))
        
        
        // Add animation to the new joke cell
        if shouldScrollToNewJoke && indexPath.row ==  presenter?.jokeArray.count ?? 1 - 1 {
            cell.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            UIView.animate(withDuration: 0.5) {
                cell.transform = .identity
            }
            
            shouldScrollToNewJoke = false
        }
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - JokeListProtocol methods
extension ViewController: JokeListProtocol {
    
    func reloadTableView() {
        UIView.transition(with: self.tableView, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.tableView.reloadData()
        })
    }
    
    func showAlertError(title: String, message: String, buttonTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - Private methods
extension ViewController {
    
    fileprivate func setupUI() {
        self.setupConstraints()
    }
    
    
    fileprivate func setupTableView() {
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(JokeTableViewCell.self, forCellReuseIdentifier: JokeTableViewCell.reuseIdentifier)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        view.addSubview(tableView)
    }
    
    fileprivate func setupConstraints() {
        // Add the table view
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 10, width: view.frame.size.width, height: 44))
        view.addSubview(navBar)
        let navItem = UINavigationItem(title: "UNLIMITED JOKES")
        navBar.setItems([navItem], animated: false)
        
        setupTableView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: navBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    
    fileprivate func loadJokes() {
        self.presenter = JokeListPresenter(view: self)
        presenter?.loadData()
    }
    
    fileprivate func updateUI() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
            if !(self.presenter?.jokeArray.isEmpty ?? true) {
                self.shouldScrollToNewJoke = true
            }
        }
    }
}
