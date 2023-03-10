//
//  ModelView.swift
//  iosdevapp
//
//  Created by Leonit Ejupi on 07.02.23.
//

import Foundation

class GenerateImageViewModel: ObservableObject {
    private let urlSession: URLSession
    @Published var imageURL: URL?
    @Published var isLoading = false
    @Published public var text: String = "Two astronauts"
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func generateImage(withText text: String) async {
        guard let url = URL(string: "https://api.openai.com/v1/images/generations") else {
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("Bearer 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", forHTTPHeaderField: "Authorization")
        
        let requestData = GenerateImageRequest(prompt: text, n: 1, size: "1024x1024")
        let encoder = JSONEncoder()
        let json = try! encoder.encode(requestData)
        
        urlRequest.httpBody = json
        
        do {
            DispatchQueue.main.async {
                self.isLoading = true
            }
            
            let (data, _) = try await urlSession.data(for: urlRequest)
            let model = try JSONDecoder().decode(GenerateImageResponse.self, from: data)
            
            DispatchQueue.main.async {
                self.isLoading = false
                
                guard let firstModel = model.data.first else {
                    return
                }
                
                self.imageURL = URL(string: firstModel.url)
                print(self.imageURL ?? "No imageURL")
            }
        } catch {
            print(error)
        }
    }
}

struct GenerateImageRequest: Encodable {
    let prompt: String
    let n: Int
    let size: String
}


