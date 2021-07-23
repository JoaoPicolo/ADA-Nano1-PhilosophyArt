//
//  ViewController.swift
//  NanoCrash1
//
//  Created by João Pedro Picolo on 21/07/21.
//

import UIKit

class ViewController: UIViewController {
    let scenes: [Scene] = ModelData().scenes
    lazy var scene = SceneView(frame: .zero, scene: scenes[0], selectionDelegate: self)
    
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

extension ViewController: CellSelectionDelegate {
    func didChangeScene(index: Int, penalty: Int) {
        let newView = SceneView(frame: .zero, scene: scenes[index], selectionDelegate: self)
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
