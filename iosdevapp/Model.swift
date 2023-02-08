//
//  Model.swift
//  iosdevapp
//
//  Created by Leonit Ejupi on 07.02.23.
//

import Foundation

struct DataResponse: Decodable {
    let url: String
}

struct ModelResponse: Decodable {
    let data: [DataResponse]
}
