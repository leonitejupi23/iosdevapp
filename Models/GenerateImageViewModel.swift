import Foundation
import UIKit

class GenerateImageViewModel: ObservableObject {
    private let urlSession: URLSession
    @Published var imageURL: URL?
    @Published var isLoading = false
    @Published public var text: String = "Two astronauts"
    @Published var showSavedImageAlert = false
    private var apiKey = ""

    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession

        do {
            let APISecretKey = try fileLoaderService(fileName: "APIKey")
            apiKey = APISecretKey.apiKey
        } catch {
            print("Failed to load API key: \(error.localizedDescription)")
        }
    }

    func generateImage(withText text: String) async {
        guard let url = URL(string: "https://api.openai.com/v1/images/generations") else {
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")

        let requestData = GenerateImageRequest(prompt: text, n: 1, size: "1024x1024")
        let encoder = JSONEncoder()
        do {
            let json = try encoder.encode(requestData)
            urlRequest.httpBody = json
        } catch {
            print(error)
        }

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
