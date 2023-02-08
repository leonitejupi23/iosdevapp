//
//  ModelView.swift
//  iosdevapp
//
//  Created by Leonit Ejupi on 07.02.23.
//

import Foundation

final class ViewModel: ObservableObject {
    private let urlSession: URLSession
    @Published var imageURL: URL?
    
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
        
        let dictionary: [String: Any] = [
            "prompt": text,
            "n": 1,
            "size": "1024x1024"
        ]
         
        urlRequest.httpBody = try! JSONSerialization.data(withJSONObject: dictionary)
        
        do {
            let (data, _) = try await urlSession.data(for: urlRequest)
            let model = try JSONDecoder().decode(ModelResponse.self, from: data)
            
            DispatchQueue.main.async {
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
