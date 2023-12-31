//
//  AdModel.swift
//  AvitoTest
//
//  Created by Дмитрий on 29.08.2023.
//



struct AdModel:Decodable {
    let advertisements: [Announcement]
}

struct Announcement: Decodable {
    let id: String
    let title: String
    let price: String
    let location: String
    let imageURL: String
    let createdDate: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case price
        case location
        case imageURL = "image_url"
        case createdDate = "created_date"
    }
}
