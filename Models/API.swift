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
          let data = try? Data(contentsOf: url),
          let jsonData = try? JSONDecoder().decode(APISecretData.self, from: data),
          let apiKeyData = Data(base64Encoded: jsonData.apiKey),
          let apiKey = String(data: apiKeyData, encoding: .utf8)
    else {
        throw JSONFileError.JSONFileNotFound
    }
    
    let decodedJsonData = APISecretData(apiKey: apiKey)
    return decodedJsonData
}
