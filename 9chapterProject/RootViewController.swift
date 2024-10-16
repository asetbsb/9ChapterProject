//
//  ViewController.swift
//  9chapterProject
//
//  Created by Asset on 10/11/24.
//

import UIKit

private let quiz = [
    Question(
        q: "A slug's blood is green.",
        a: "True"
    ),
    Question(
        q: "Approximately one quarter of human bones are in the feet.",
        a: "True"
    ),
    Question(
        q: "The total surface area of two human lungs is approximately 70 square metres.",
        a: "True"
    ),
    Question(
        q: "In West Virginia, USA, if you accidentally hit an animal with your car, you are free to take it home to eat.",
        a: "True"
    ),
    Question(
        q: "In London, UK, if you happen to die in the House of Parliament, you are technically entitled to a state funeral, because the building is considered too sacred a place.",
        a: "False"),
    Question(
        q: "It is illegal to pee in the Ocean in Portugal.",
        a: "True"
    ),
    Question(
        q: "You can lead a cow down stairs but not up stairs.",
        a: "False"
    ),
    Question(
        q: "Google was originally called 'Backrub'.",
        a: "True"
    ),
    Question(
        q: "Buzz Aldrin's mother's maiden name was 'Moon'.",
        a: "True"
    ),
    Question(
        q: "The loudest sound produced by any animal is 188 decibels. That animal is the African Elephant.",
        a: "False"
    ),
    Question(
        q: "No piece of square dry paper can be folded in half more than 7 times.",
        a: "False"
    ),
    Question(
        q: "Chocolate affects a dog's heart and nervous system; a few ounces are enough to kill a small dog.",
        a: "True"
    )
]

final class RootViewController: UIViewController {
    private var questionCount = 0
    private var scoreCount = 0
    
    //MARK: - UI Elements
    private lazy var scoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "Score: \(scoreCount)"
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    private lazy var questionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.text = quiz[questionCount].text
        return label
    }()

    private lazy var trueButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false

        button.backgroundColor = UIColor(rgb: 0x024CAA)
        button.layer.cornerRadius = 12
        button.setTitle("True", for: .normal)
        button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var falseButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false

        button.backgroundColor = UIColor(rgb: 0x024CAA)
        button.layer.cornerRadius = 12
        button.setTitle("False", for: .normal)
        button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var progressBar: UIProgressView = {
        let progressBar = UIProgressView()
        progressBar.translatesAutoresizingMaskIntoConstraints = false

        progressBar.progressViewStyle = .bar
        progressBar.progressTintColor = UIColor(rgb: 0xEC8305)
        progressBar.trackTintColor = UIColor(rgb: 0xDBD3D3)
        progressBar.layer.cornerRadius = 10
        return progressBar
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: - Helper methods
    
    private func setupUI() {
        view.backgroundColor = UIColor(rgb: 0x091057)
        
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        view.addSubview(scoreLabel)
        view.addSubview(questionLabel)
        view.addSubview(trueButton)
        view.addSubview(falseButton)
        view.addSubview(progressBar)
    }
    
    private func setupConstraints() {
        let height = UIScreen.main.bounds.size.height

        NSLayoutConstraint.activate([
            scoreLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            scoreLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            
            questionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            questionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: height * 0.2),
            questionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            questionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            
            progressBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            progressBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            progressBar.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.8),
            progressBar.heightAnchor.constraint(equalToConstant: 15),
            
            falseButton.bottomAnchor.constraint(equalTo: progressBar.topAnchor, constant: -20),
            falseButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            falseButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            
            trueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            trueButton.bottomAnchor.constraint(equalTo: falseButton.topAnchor, constant: -20),
            trueButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7)
        ])
    }
    
    // MARK: - Button actions

    @objc private func buttonPressed(_ button: UIButton) {
        if questionCount == quiz.count {
            questionCount = 0
            scoreCount = 0
        } else {
            if button.currentTitle == quiz[questionCount].answer {
                scoreCount += 1
                button.backgroundColor = .green
            } else {
                button.backgroundColor = .red
            }
            createTimer()
        }
    }
    
    private func createTimer() {
        Timer.scheduledTimer(
            timeInterval: 0.2,
            target: self,
            selector: #selector(updateUI),
            userInfo: nil, 
            repeats: false
        )
    }
    
    @objc private func updateUI() {
        progressBar.progress = Float(questionCount) / Float(quiz.count)
        scoreLabel.text = "Score: \(scoreCount)"
        questionLabel.text = quiz[questionCount].text
        trueButton.backgroundColor = UIColor(rgb: 0x024CAA)
        falseButton.backgroundColor = UIColor(rgb: 0x024CAA)
        questionCount += 1
    }

}

