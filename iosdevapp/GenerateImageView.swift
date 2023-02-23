//
//  GenerateView.swift
//  iosdevapp
//
//  Created by Leonit Ejupi on 08.02.23.
//

import SwiftUI

struct GenerateImageView: View {
    @StateObject var viewModel = GenerateImageViewModel()
    @State private var isLoading = false
    
    var body: some View {
        VStack {
            Color.red
                .frame(minWidth: nil, idealWidth: nil, maxWidth: nil, minHeight: nil, idealHeight: nil, maxHeight: 10)
            Text("AI GENERATE IMAGES")
            Form {
                AsyncImage(url: viewModel.imageURL) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .overlay(alignment: .bottomTrailing, content: {
                            Button {
                                viewModel.saveImageToGallery()
                            } label: {
                                HStack {
                                    Image(systemName: "arrow.down.circle.fill")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .shadow(color: .black, radius: 0.2)
                                }
                                .padding(8)
                                .foregroundColor(.green)
                            }
                        })
                }
                
            placeholder: {
                VStack {
                    if isLoading {
                        ProgressView()
                            .padding(.bottom, 12)
                        Text("AI is Exploring...")
                    } else {
                        Image(systemName: "photo.on.rectangle.angled")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                    }
                }
                .frame(width: 300, height: 300)
            }
                
                TextField("Describe the image you want",
                          text: $viewModel.text,
                          axis: .vertical)
                          .lineLimit(10)
                          .lineSpacing(5)
                
                HStack {
                    Spacer()
                    Button("Generate Image") {
                        Task {
                            isLoading = true
                            await viewModel.generateImage(withText: viewModel.text)
                            isLoading = false
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(viewModel.text.trimmingCharacters(in: CharacterSet.whitespaces).isEmpty)
                    .padding(.vertical)
                    Spacer()
                }
            }
        }
        
    }
}


