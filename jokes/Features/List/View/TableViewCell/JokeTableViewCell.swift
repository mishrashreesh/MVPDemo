//
//  JokeTableViewCell.swift
//  jokes
//
//  Created by ShrishMishra on 26/08/23.
//

import UIKit

class JokeTableViewCell: UITableViewCell {

    static let reuseIdentifier = "JokeTableViewCell"
    
    private let jokeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .left
        label.backgroundColor = .clear
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        // Add a  background view to the cell
        let backgroundView = UIView()
        backgroundView.backgroundColor = .green
        backgroundView.layer.cornerRadius = 10
        backgroundView.layer.masksToBounds = true
        
        contentView.addSubview(backgroundView)
        
        // Configure auto layout constraints
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            backgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            backgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            backgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
        
        // Add the label
        backgroundView.addSubview(jokeLabel)
        
        // Configure auto layout constraints
        jokeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            jokeLabel.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 12),
            jokeLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 12),
            jokeLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -12),
            jokeLabel.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -12)
        ])
    }
    
    func configure(with joke: String) {
        jokeLabel.text = joke
    }
    
}

class Header: UIView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Joke Assignment"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.black
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
    
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
