//
//  MainViewController.swift
//  EggTimer
//
//  Created by Sergey Zakurakin on 01/06/2024.
//

import UIKit
import AVFoundation

final class MainViewController: UIViewController {
    
    //MARK: - Private propertis
    private var eggsTime = ["soft" : 3, "medium" : 420, "hard" : 720]
    private var timer = Timer()
    private var totalTime = 0
    private var secondPassed = 0
    private var player: AVAudioPlayer?
    
    
    // MARK: - UI
    private lazy var mainStackView: UIStackView = {
        let element = UIStackView()
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
        element.spacing = 20
        element.distribution = .fillEqually
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var softImageView = UIImageView(imageName: "soft_egg")
    private lazy var mediumImageView = UIImageView(imageName: "medium_egg")
    private lazy var hardImageView = UIImageView(imageName: "hard_egg")
    
    private lazy var softEggButton = UIButton(text: "soft")
    private lazy var mediumEggButton = UIButton(text: "medium")
    private lazy var hardEggButton = UIButton(text: "hard")
    
    private lazy var timerView: UIView = {
        let element = UIView()
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var progressView: UIProgressView = {
        let element = UIProgressView()
        element.tintColor = .yellow
        element.trackTintColor = .systemGray
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
    }
    
    // MARK: - Bussines Logic
    @objc func eggsButtonPressed(_ sender: UIButton) {
        
        timer.invalidate()
        progressView.setProgress(0.0, animated: true)
        secondPassed = 0
        
        let hardness = sender.currentTitle ?? "error"
        titleLabel.text = hardness
  
        totalTime = eggsTime[hardness] ?? 0

        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    
    @objc func updateCounter() {
        //example functionality
        
        if secondPassed <= totalTime {
            let percentageProgress = Float(secondPassed) / Float(totalTime)
            secondPassed += 1
            progressView.progress = percentageProgress
            
        } else {
            secondPassed = 0
            timer.invalidate()
            progressView.setProgress(1, animated: true)
            playSound()
            titleLabel.text = "Done"
        }
    }
    
    func playSound() {
        guard let path = Bundle.main.path(forResource: "alarm_sound", ofType:"mp3") else {
            return }
        let url = URL(fileURLWithPath: path)
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
}


// MARK: - Setup Views and Constraints
extension MainViewController {
    
    private func setupViews() {
        view.backgroundColor = .systemCyan
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
        
        softEggButton.addTarget(self, action: #selector(eggsButtonPressed), for: .touchUpInside)
        mediumEggButton.addTarget(self, action: #selector(eggsButtonPressed), for: .touchUpInside)
        hardEggButton.addTarget(self, action: #selector(eggsButtonPressed), for: .touchUpInside)
        
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

// MARK: - UIButton
extension UIButton {
    convenience init(text: String) {
        self.init(type: .system)
        
        self.setTitle(text, for: .normal)
        self.setTitleColor(.black, for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 18)
        
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

// MARK: - UIImageView
extension UIImageView {
    convenience init(imageName: String) {
        self.init()
        
        self.image = UIImage(named: imageName)
        self.contentMode = .scaleAspectFit
        self.isUserInteractionEnabled = true
        
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
