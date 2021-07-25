//
//  ViewController.swift
//  NanoCrash1
//
//  Created by João Pedro Picolo on 21/07/21.
//

import UIKit

class ViewController: UIViewController {
    
    @objc private func didStartGame() {
        let rootVC = SceneViewController()
        
        let navigationVC = UINavigationController(rootViewController: rootVC)
        navigationVC.modalPresentationStyle = .fullScreen
        present(navigationVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "appBackground")
        
        let description = UILabel()
        description.text = "Philosophy\n\t\t\t\tArt"
        description.numberOfLines = 0
        description.translatesAutoresizingMaskIntoConstraints = false
        description.font = UIFont.systemFont(ofSize: 60, weight: .medium)
        description.textColor = UIColor(named: "appText")
        self.view.addSubview(description)
        
        let imageView: UIImageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "mainIcon")
        self.view.addSubview(imageView)
        
        let button: UIButton = UIButton(frame: .zero)
        button.addTarget(self, action:#selector(self.didStartGame), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor(named: "appText")!.cgColor
        button.layer.cornerRadius = 20
        button.setTitle("Começar", for: .normal)
        button.setTitleColor(UIColor(named: "appText"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        self.view.addSubview(button)
        
        NSLayoutConstraint.activate([
            description.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            description.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -(view.bounds.height / 4)),
            
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: (view.bounds.height / 2.4)),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -(view.bounds.height / 3)),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: (view.bounds.width / 5)),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -(view.bounds.width / 5)),
            
            button.topAnchor.constraint(equalTo: view.topAnchor, constant: (view.bounds.height / 1.3)),
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -(view.bounds.height / 6)),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: (view.bounds.width / 6)),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -(view.bounds.width / 6)),
        ])
    }
}
