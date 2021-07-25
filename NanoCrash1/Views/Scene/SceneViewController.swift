//
//  SceneViewController.swift
//  NanoCrash1
//
//  Created by João Pedro Picolo on 23/07/21.
//

import UIKit

class SceneViewController: UIViewController {
    let scenes: [Scene] = ModelData().scenes
    var kimonos: [String] = ModelData().kimonos
    var descriptions: [String] = ModelData().descriptions
    var finalGraduation = 0
    var currentIndex = 0
    lazy var scene = SceneView(frame: view.frame, scene: scenes[currentIndex], selectionDelegate: self)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupComponents()
        setupConstraints()
    }
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .systemBackground
        self.view = view
    }

    func setupHierarchy() {
        self.view.addSubview(scene)
    }
    
    func setupComponents() {
        scene.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            scene.topAnchor.constraint(equalTo: view.topAnchor),
            scene.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scene.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scene.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}

extension SceneViewController: CellSelectionDelegate {
    func didChangeScene(index: Int, penalty: Int) {
        finalGraduation += penalty
        if (currentIndex == 4 && index == 0) { // It's on last screen and will play again
            currentIndex = index
            dismiss(animated: true, completion: nil)
        }
        else {
            if index != 4 { // It's not on last scene
                currentIndex = index
                let newView = SceneView(frame: .zero, scene: scenes[currentIndex], selectionDelegate: self)
                SceneView.animate(withDuration: 0.3,
                                    animations: { self.scene.alpha = 0.0 },
                                    completion: {(value: Bool) in
                                        self.scene.removeFromSuperview()
                                        self.scene = newView
                                        self.setupHierarchy()
                                        self.setupComponents()
                                        self.setupConstraints()
                                    })
            }
            else {
                currentIndex = index
                var newScene = scenes[currentIndex]
                var newDescription: String
                var newImageName: String
                if finalGraduation > 0 {
                    newDescription = descriptions[finalGraduation]
                    newImageName = kimonos[finalGraduation]
                }
                else {
                    newDescription = descriptions[0]
                    newImageName = kimonos[0]
                }

                newScene.description = newDescription
                newScene.options.append(Option(description: "Voltar ao início", nextScene: 0, penalty: -finalGraduation, imageName: newImageName))
                let newView = SceneView(frame: .zero, scene: newScene, selectionDelegate: self)
                SceneView.animate(withDuration: 0.3,
                                    animations: { self.scene.alpha = 0.0 },
                                    completion: {(value: Bool) in
                                        self.scene.removeFromSuperview()
                                        self.scene = newView
                                        self.setupHierarchy()
                                        self.setupComponents()
                                        self.setupConstraints()
                                    })
            }
        }
    }
}
