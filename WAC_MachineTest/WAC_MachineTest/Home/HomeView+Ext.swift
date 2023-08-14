//
//  HomeView+Ext.swift
//  WAC_MachineTest
//
//  Created by Chandra Mohan on 14/08/23.
//

import UIKit
extension HomeView : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoryCollectionView{
            return viewModel.allCategories.count
        }
        else{
            return viewModel.allProducts.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categoryCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as? CategoryCollectionViewCell
            let categoryObject = viewModel.allCategories[indexPath.item]
            cell?.configure(categoryObject: categoryObject)
            return cell!
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as? ProductCollectionViewCell
            let productObject = viewModel.allProducts[indexPath.item]
            cell?.config(productObject: productObject)
            return cell!
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == categoryCollectionView{
            return 1.0
        }
        else{
            return 5.0
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == categoryCollectionView{
            return CGSize(width: 100, height: 100)
        }
        else{
            return CGSize(width: 180, height: 300)
        }
        
    }
}
