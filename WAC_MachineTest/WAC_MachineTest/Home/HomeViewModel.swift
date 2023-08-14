//
//  HomeViewModel.swift
//  WAC_MachineTest
//
//  Created by Chandra Mohan on 14/08/23.
//
import Foundation
import UIKit

class ViewModel {
    var homeDataModel: HomeData?
    var orderArray = [String()]
    var bannerURLs = [String()]
    var allCategories = [CategoryData]()
    var allProducts = [Products]()
    
    func fetchData(completion: @escaping () -> Void) {
        let urlString = "https://run.mocky.io/v3/69ad3ec2-f663-453c-868b-513402e515f0" //"https://run.mocky.io/v3/aeab37f6-313c-43b4-8659-a328387c9dfd"//
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { [self] data, _, error in
            if let data = data {
                do {
                    
                    let decodedData = try JSONDecoder().decode(HomeData.self, from: data)
                    let homeData = decodedData.homeData
                    
                    //fetch Order Array
                    self.orderArray =  homeData.map{$0.type}
                    self.homeDataModel = decodedData
                    
                    //fetch Banner urls
                    let banners = homeData.filter { $0.type == "banners" }
                    bannerURLs = banners.flatMap { $0.values.map { $0.banner_url ?? "" } }
                    
                    let categories = homeData.filter { $0.type == "category" }
                     let products = homeData.filter { $0.type == "products" }

                    allCategories = categories.flatMap { $0.values.map { CategoryData(id: $0.id, name: $0.name, imageURL: $0.image_url)  } }
                    
                    allProducts = products.flatMap { $0.values.map { Products(id: $0.id, name: $0.name, image: $0.image, actualPrice: $0.actual_price, offerPrice: $0.offer_price, offer: $0.offer, isExpress: $0.is_express) } }

                    
                    completion()
                } catch {
                    print("Error decoding data: \(error)")
                }
            }
        }.resume()
    }
    

}
