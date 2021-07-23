//
//  Carousel.swift
//  NanoCrash1
//
//  Created by João Pedro Picolo on 21/07/21.
//

import UIKit

protocol CellSelectionDelegate {
    func didChangeScene(index: Int, penalty: Int)
}

class Carousel: UIView {
    private lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: CarouselLayout()
    )
    
    var options: [Option] = []
    var selectedIndex: Int = 0
    var selectionDelegate: CellSelectionDelegate!
    
    public init(frame: CGRect, options: [Option]) {
        self.options = options
        super.init(frame: frame)
        setupView()
    }
    
    // init from xib or storyboard
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(collectionView)
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.x
        let w = scrollView.bounds.size.width
        let currentPage = Int(ceil(x/w))
        
        selectedIndex = currentPage
    }
}

extension Carousel: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return options.count
    }
    
    @objc
    func cellTapped(sender:UITapGestureRecognizer) {
        selectionDelegate.didChangeScene(index: options[selectedIndex].nextScene, penalty: options[selectedIndex].penalty)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        let tap = UITapGestureRecognizer(target: self, action: #selector(Carousel.cellTapped))
        cell.isUserInteractionEnabled = true
        cell.addGestureRecognizer(tap)
        
        let imageView: UIImageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = options[indexPath.row].image
        cell.contentView.addSubview(imageView)
    
        
        let button: UIButton = UIButton(frame: .zero)
        button.addTarget(self, action:#selector(Carousel.cellTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 0.5
        button.layer.borderColor = (UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)).cgColor
        button.layer.cornerRadius = 20
        button.setTitle(options[indexPath.row].description, for: .normal)
        button.setTitleColor(.black, for: .normal)
        cell.contentView.addSubview(button)
            
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: cell.topAnchor, constant: 220),
            imageView.bottomAnchor.constraint(equalTo: cell.bottomAnchor, constant: -250),
            imageView.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 60),
            imageView.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: -60),
            
            button.topAnchor.constraint(equalTo: cell.topAnchor, constant: 520),
            button.bottomAnchor.constraint(equalTo: cell.bottomAnchor, constant: -160),
            button.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 60),
            button.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: -60),
        ])
        return cell
    }
}

extension Carousel: UICollectionViewDelegate {}
