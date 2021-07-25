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
    
    let screenBounds = UIScreen.main.bounds
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
    
    @objc private func cellTapped(sender:UITapGestureRecognizer) {
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
        button.layer.borderColor = UIColor(named: "appText")!.cgColor
        button.layer.cornerRadius = 20
        button.setTitle(options[indexPath.row].description, for: .normal)
        button.setTitleColor(UIColor(named: "appText"), for: .normal)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title3)
        cell.contentView.addSubview(button)
            
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: cell.topAnchor, constant: (screenBounds.height / 3.5)),
            imageView.bottomAnchor.constraint(equalTo: cell.bottomAnchor, constant: -(screenBounds.height / 3)),
            imageView.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: (screenBounds.width / 6)),
            imageView.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: -(screenBounds.width / 6)),
            
            button.topAnchor.constraint(equalTo: cell.topAnchor, constant: (screenBounds.height / 1.6)),
            button.bottomAnchor.constraint(equalTo: cell.bottomAnchor, constant: -(screenBounds.height / 5)),
            button.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: (screenBounds.width / 6)),
            button.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: -(screenBounds.width / 6)),
        ])
        return cell
    }
}

extension Carousel: UICollectionViewDelegate {}
