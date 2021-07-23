//
//  SceneView.swift
//  NanoCrash1
//
//  Created by João Pedro Picolo on 21/07/21.
//

import UIKit

class SceneView: UIView {
    private lazy var sceneView = UIView(frame: .zero)
    
    var scene: Scene
    var carousel: Carousel
    var sceneDescription = UILabel()

    public init(frame: CGRect, scene: Scene, selectionDelegate: CellSelectionDelegate) {
        self.scene = scene
        self.carousel = Carousel(frame: .zero, options: scene.options)
        self.carousel.selectionDelegate = selectionDelegate
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        sceneView.backgroundColor = .clear
        sceneView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(sceneView)
        
        sceneDescription.text = scene.description
        sceneDescription.numberOfLines = 0
        sceneDescription.translatesAutoresizingMaskIntoConstraints = false
//        sceneDescription.font = UIFont(name: ".SFProText-Regular", size: 18)
        sceneView.addSubview(sceneDescription)
        
        carousel.translatesAutoresizingMaskIntoConstraints = false
        sceneView.addSubview(carousel)
        
        NSLayoutConstraint.activate([
            sceneView.topAnchor.constraint(equalTo: topAnchor),
            sceneView.bottomAnchor.constraint(equalTo: bottomAnchor),
            sceneView.trailingAnchor.constraint(equalTo: trailingAnchor),
            sceneView.leadingAnchor.constraint(equalTo: leadingAnchor),

            sceneDescription.topAnchor.constraint(equalTo: topAnchor, constant: -450),
            sceneDescription.bottomAnchor.constraint(equalTo: bottomAnchor),
            sceneDescription.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            sceneDescription.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            
            carousel.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            carousel.bottomAnchor.constraint(equalTo: bottomAnchor),
            carousel.leadingAnchor.constraint(equalTo: leadingAnchor),
            carousel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}
