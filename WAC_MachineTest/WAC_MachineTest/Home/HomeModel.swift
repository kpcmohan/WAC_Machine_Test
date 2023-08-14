//
//  HomeModel.swift
//  WAC_MachineTest
//
//  Created by Chandra Mohan on 14/08/23.
//


import Foundation

struct HomeData: Codable {
    let status: Bool
    let homeData: [HomeSection]
}

struct HomeSection: Codable {
    let type: String
    let values: [HomeSectionItem]
}

struct HomeSectionItem: Codable {
    let id: Int?
    let name: String?
    let image_url: String?
    let image: String?
    let banner_url: String?
    let actual_price: String?
    let offer_price: String?
    let offer: Int?
    let is_express: Bool?
}

// MARK: - Banners
struct Banner: Codable {
    let id: Int?
    let bannerURL: String?

    enum CodingKeys: String, CodingKey {
        case id
        case bannerURL = "banner_url"
    }
}


// MARK: - Cateory
struct CategoryData: Codable {
    let id: Int?
    let name: String?
    let imageURL: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case imageURL = "image_url"
    }
}

// MARK: - Products
struct Products: Codable {
    let id: Int?
    let name: String?
    let image: String?
    let actualPrice, offerPrice: String?
    let offer: Int?
    let isExpress: Bool?

    enum CodingKeys: String, CodingKey {
        case id, name, image
        case actualPrice = "actual_price"
        case offerPrice = "offer_price"
        case offer
        case isExpress = "is_express"
    }
}

