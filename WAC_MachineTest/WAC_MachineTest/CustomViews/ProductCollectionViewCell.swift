//
//  ProductCollectionViewCell.swift
//  Test
//
//  Created by Chandra Mohan on 14/08/23.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgDelivery: UIImageView!
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var imgOffer: UIImageView!
    @IBOutlet weak var lblOriginalAmount: UILabel!
    @IBOutlet weak var lblOfferAmount: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var lblOffer: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        containerView.layer.borderWidth = 1.0
        containerView.layer.cornerRadius = 6.0
        containerView.layer.borderColor = UIColor.gray.cgColor
    }
    
    func config(productObject: Products) {
        // Show the % OFF only if the offer is greater than 0
        if let offer = productObject.offer, offer > 0 {
            lblOffer.text = "\(offer)% OFF"
            imgOffer.image = UIImage(named: "badge")
        } else {
            lblOffer.text = nil
            imgOffer.isHidden = true
        }
        
        lblOfferAmount.text = productObject.offerPrice
        
        // Show the actual price and offer price only if they are different
        let cleanActualPrice = productObject.actualPrice?.replacingOccurrences(of: "₹ ", with: "").trimmingCharacters(in: .whitespaces)
        let cleanOfferPrice = productObject.offerPrice?.replacingOccurrences(of: "₹ ", with: "").trimmingCharacters(in: .whitespaces)
           
           if cleanActualPrice != cleanOfferPrice {
               lblOfferAmount.text = productObject.offerPrice
               lblOriginalAmount.text = productObject.actualPrice
               let actualPriceAttributes: [NSAttributedString.Key: Any] = [
                           .strikethroughStyle: NSUnderlineStyle.single.rawValue,
                           .strikethroughColor: UIColor.gray
                       ]
               let actualPriceAttributedString = NSAttributedString(string: productObject.actualPrice ?? "", attributes: actualPriceAttributes)
                     lblOriginalAmount.attributedText = actualPriceAttributedString
           } else {
               lblOfferAmount.text = productObject.offerPrice
               lblOriginalAmount.text = nil
           }
        
        lblDescription.text = productObject.name
        
        // Show or hide the yellow truck image based on the is_express value
        imgDelivery.isHidden = !(productObject.isExpress ?? true)
        
        // Set a placeholder image by default
        imgProduct.image = UIImage(named: "productPlaceholder")
        
        DispatchQueue.main.async {
            if let url = URL(string: productObject.image ?? "") {
                // Fetch and set the image from URL
                URLSession.shared.dataTask(with: url) { data, _, error in
                    if let data = data {
                        DispatchQueue.main.async {
                            self.imgProduct.image = UIImage(data: data)
                        }
                    }
                }.resume()
            }
        }
    }

}
