//
//  API.swift
//  iosdevapp
//
//  Created by Leonit Ejupi on 02.03.23.
//

import Foundation

enum JSONFileError : Error{
    case JSONFileNotFound
}

func fileLoaderService(fileName: String) throws -> APISecretData {
    guard let url = Bundle.main.url(forResource: fileName, withExtension: "json"),
          let data = try? Data(contentsOf: url ),
          let jsonData = try? JSONDecoder().decode(APISecretData.self, from: data)
    else{
        throw JSONFileError.JSONFileNotFound
    }
    return jsonData
}
