//
//  HomeView.swift
//  WAC_MachineTest
//
//  Created by Chandra Mohan on 14/08/23.
//

import UIKit

class HomeView: UIViewController {
    
    @IBOutlet weak var stackView: UIStackView!
    
    let bannerScrollView = UIScrollView()
    var bannerStackView: UIStackView!
    
    var categoryCollectionView : UICollectionView!
    var productCollectionView : UICollectionView!
    
    let viewModel = ViewModel()
    let screenWidth = UIScreen.main.bounds.width
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCategoryCollectionView()
        setupProductCollectionView()
        viewModel.fetchData {
            DispatchQueue.main.async {
                self.setupViews()
            }
        }
    }
    
    func setupCategoryCollectionView() {
        // Initialize a UICollectionViewFlowLayout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: screenWidth / 4, height: 150 ) // Set your desired cell size
        
        // Initialize the UICollectionView
        categoryCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        categoryCollectionView.translatesAutoresizingMaskIntoConstraints = false
        categoryCollectionView.backgroundColor = .white
        
        // Register a UICollectionViewCell class from a XIB
        let cellNib = UINib(nibName: "CategoryCollectionViewCell", bundle: nil)
        categoryCollectionView.register(cellNib, forCellWithReuseIdentifier: "CategoryCell")
        
        
        // Set the delegate and dataSource
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
 
    }
    func setupProductCollectionView() {
        // Initialize a UICollectionViewFlowLayout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: screenWidth / 2.3, height: 250 ) // Set your desired cell size
        
        // Initialize the UICollectionView
        productCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        productCollectionView.translatesAutoresizingMaskIntoConstraints = false
        productCollectionView.backgroundColor = .white
        
        // Register a UICollectionViewCell class from a XIB
        let cellNib = UINib(nibName: "ProductCollectionViewCell", bundle: nil)
        productCollectionView.register(cellNib, forCellWithReuseIdentifier: "ProductCell")
        
        
        // Set the delegate and dataSource
        productCollectionView.delegate = self
        productCollectionView.dataSource = self
 
    }
    
    func setupViews() {
        guard let homeData = viewModel.homeDataModel else { return }
        
        // Order of section types
        let sectionOrder = viewModel.orderArray
        
        // Iterate through section types and create views accordingly
        for sectionType in sectionOrder {
            let sectionView = createView(for: sectionType)
            stackView.addArrangedSubview(sectionView)
        }
    }
    
    
    func createView(for type: String) -> UIView {
        switch type{
        case "category":
            
            NSLayoutConstraint.activate([
                categoryCollectionView.heightAnchor.constraint(equalToConstant: 100)
                // Add any other necessary constraints here
            ])
            categoryCollectionView.reloadData()
            return categoryCollectionView
        case "banners":
            setupBannerStackView()
            NSLayoutConstraint.activate([
                bannerStackView.heightAnchor.constraint(equalToConstant: 180)
                // Add any other necessary constraints here
            ])
            return bannerScrollView
        case "products":
            
            NSLayoutConstraint.activate([
                productCollectionView.heightAnchor.constraint(equalToConstant: 300)
                // Add any other necessary constraints here
            ])
            productCollectionView.reloadData()
            return productCollectionView
        default:
            let view = UIView()
            
            NSLayoutConstraint.activate([
                view.heightAnchor.constraint(equalToConstant: 100)
            ])
            view.backgroundColor = .red
            return view
            
        }
        
        
    }
    
    func setupBannerStackView() {
        bannerStackView = UIStackView()
        bannerStackView.axis = .horizontal
        bannerStackView.spacing = 8.0 // Adjust as needed
        bannerStackView.translatesAutoresizingMaskIntoConstraints = false
        
        bannerScrollView.addSubview(bannerStackView)
        bannerScrollView.showsHorizontalScrollIndicator = false
        NSLayoutConstraint.activate([
            bannerStackView.leadingAnchor.constraint(equalTo: bannerScrollView.leadingAnchor),
            bannerStackView.trailingAnchor.constraint(equalTo: bannerScrollView.trailingAnchor),
            bannerStackView.topAnchor.constraint(equalTo: bannerScrollView.topAnchor),
            bannerStackView.bottomAnchor.constraint(equalTo: bannerScrollView.bottomAnchor),
            bannerStackView.heightAnchor.constraint(equalTo: bannerScrollView.heightAnchor)
        ])
        loadBannerImages()
    }
    
    func loadBannerImages() {
        let bannerImageURLs: [String?] = viewModel.bannerURLs
        
        // Calculate the desired width for the image views (80% of the screen width)
        
        let imageViewWidth = screenWidth * 0.8
        
        for imageURLString in bannerImageURLs {
            if let urlString = imageURLString, let url = URL(string: urlString) {
                let imageView = UIImageView()
                imageView.contentMode = .scaleAspectFit
                imageView.clipsToBounds = true
                imageView.widthAnchor.constraint(equalToConstant: imageViewWidth).isActive = true
                imageView.setContentHuggingPriority(.required, for: .vertical)
                imageView.setContentCompressionResistancePriority(.required, for: .vertical)
                
                // Fetch and set the image from URL
                URLSession.shared.dataTask(with: url) { data, _, error in
                    if let data = data {
                        DispatchQueue.main.async {
                            imageView.image = UIImage(data: data)
                        }
                    }
                }.resume()
                
                bannerStackView.addArrangedSubview(imageView)
            }
        }
    }
    
    
}





