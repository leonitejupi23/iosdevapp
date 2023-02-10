//
//  GenerateView.swift
//  iosdevapp
//
//  Created by Leonit Ejupi on 08.02.23.
//

import SwiftUI

struct GenerateView: View {
    @State var text: String = "Two astronauts"
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            Text("AI GENERATE IMAGES")
            Form {
                AsyncImage(url: viewModel.imageURL) { image in
                    image
                        .resizable()
                        .scaledToFit()
                }
            placeholder: {
                VStack {
                    if !viewModel.isLoading {
                        Image(systemName: "photo.on.rectangle.angled")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                    } else {
                        ProgressView()
                            .padding(.bottom, 12)
                        Text("AI is Exploring...")
                    }
                }
                        .frame(width: 300, height: 300)
                }
            
                TextField("Describe the image you want",
                          text: $text,
                          axis: .vertical)
                .lineLimit(10)
                .lineSpacing(5)
                
                HStack {
                    Spacer()
                    Button("Generate Image") {
                        Task {
                            await viewModel.generateImage(withText: text)
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(viewModel.isLoading)
                    .padding(.vertical)
                    Spacer()
                }
            }
        }
    }
}

struct GenerateView_Previews: PreviewProvider {
    static var previews: some View {
        GenerateView()
    }
}
