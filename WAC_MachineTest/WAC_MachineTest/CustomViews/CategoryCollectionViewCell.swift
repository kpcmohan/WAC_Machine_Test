//
//  CategoryCollectionViewCell.swift
//  Test
//
//  Created by Chandra Mohan on 14/08/23.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var txtCategoryName: UILabel!
    @IBOutlet weak var imgCategory: UIImageView!
    @IBOutlet weak var viewImageContainer: UIView!
   
    func configure(categoryObject : CategoryData) {
        txtCategoryName.text = categoryObject.name
        viewImageContainer.layer.cornerRadius = viewImageContainer.frame.size.width / 2
        let url = URL(string: categoryObject.imageURL ?? "")!
        // Fetch and set the image from URL
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                DispatchQueue.main.async {
                    self.imgCategory.image = UIImage(data: data)
                }
            }
        }.resume()
        
        
    }

}
