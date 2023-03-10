//
//  Model.swift
//  iosdevapp
//
//  Created by Leonit Ejupi on 07.02.23.
//

import Foundation

struct ImageURL: Decodable {
    let url: String
}

struct GenerateImageResponse: Decodable {
    let data: [ImageURL]
}
