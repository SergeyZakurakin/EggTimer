//
//  MainViewController.swift
//  EggTimer
//
//  Created by Sergey Zakurakin on 01/06/2024.
//

import UIKit

final class MainViewController: UIViewController {

    
    // MARK: - UI
    private lazy var mainStackView: UIStackView = {
        let element = UIStackView()
        element.backgroundColor = .lightGray
        element.spacing = 0
        element.distribution = .fillEqually
        element.axis = .vertical
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var titleLabel: UILabel = {
        let element = UILabel()
        element.text = "How do you like your eggs?"
        element.font = UIFont.systemFont(ofSize: 20)
        element.textAlignment = .center

        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var eggsStackView: UIStackView = {
        let element = UIStackView()
        element.backgroundColor = .systemGray
        element.spacing = 20
        element.distribution = .fillEqually

        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var softImageView: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(named: "soft_egg")
        element.contentMode = .scaleAspectFit
        element.isUserInteractionEnabled = true
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var softEggButton: UIButton = {
        let element = UIButton()
        element.setTitle("soft", for: .normal)
        element.setTitleColor(.black, for: .normal)
        element.titleLabel?.font = .systemFont(ofSize: 18)
        element.addTarget(self, action: #selector(eggsButtonPressed), for: .touchUpInside)
        
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()

    private lazy var mediumImageView: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(named: "medium_egg")
        element.contentMode = .scaleAspectFit
        element.isUserInteractionEnabled = true
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var mediumEggButton: UIButton = {
        let element = UIButton()
        element.setTitle("medium", for: .normal)
        element.setTitleColor(.black, for: .normal)
        element.titleLabel?.font = .systemFont(ofSize: 18)
        element.addTarget(self, action: #selector(eggsButtonPressed), for: .touchUpInside)
        
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var hardImageView: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(named: "hard_egg")
        element.contentMode = .scaleAspectFit
        element.isUserInteractionEnabled = true
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var hardEggButton: UIButton = {
        let element = UIButton()
        element.setTitle("hard", for: .normal)
        element.setTitleColor(.black, for: .normal)
        element.titleLabel?.font = .systemFont(ofSize: 18)
        element.addTarget(self, action: #selector(eggsButtonPressed), for: .touchUpInside)
        
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var timerView: UIView = {
        let element = UIView()

        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var progressView: UIProgressView = {
        let element = UIProgressView()
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
 
        setupViews()
        setupConstraints()
    }
    
    @objc private func eggsButtonPressed(_ sender: UIButton) {
        print(sender.titleLabel?.text)
    }
    
}

// MARK: - Setup Views and Constraints
extension MainViewController {
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(titleLabel)
        mainStackView.addArrangedSubview(eggsStackView)
        mainStackView.addArrangedSubview(timerView)
        
        timerView.addSubview(progressView)
        eggsStackView.addArrangedSubview(softImageView)
        eggsStackView.addArrangedSubview(mediumImageView)
        eggsStackView.addArrangedSubview(hardImageView)
        
        softImageView.addSubview(softEggButton)
        mediumImageView.addSubview(mediumEggButton)
        hardImageView.addSubview(hardEggButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            progressView.centerYAnchor.constraint(equalTo: timerView.centerYAnchor),
            progressView.leadingAnchor.constraint(equalTo: timerView.leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: timerView.trailingAnchor),
            
            softEggButton.centerXAnchor.constraint(equalTo: softImageView.centerXAnchor),
            softEggButton.centerYAnchor.constraint(equalTo: softImageView.centerYAnchor),
            mediumEggButton.centerXAnchor.constraint(equalTo: mediumImageView.centerXAnchor),
            mediumEggButton.centerYAnchor.constraint(equalTo: mediumImageView.centerYAnchor),
            hardEggButton.centerXAnchor.constraint(equalTo: hardImageView.centerXAnchor),
            hardEggButton.centerYAnchor.constraint(equalTo: hardImageView.centerYAnchor)
            
        ])
    }

}
