//
//  ContentView.swift
//  iosdevapp
//
//  Created by Leonit Ejupi on 31.01.23.
//


import SwiftUI


struct ContentView: View {
    @State private var text: String = ""
    let api = "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"
    
//    func BtnGenerate() {
//        let
//    }

    var body: some View {
        ScrollView {
            VStack {
                Section {
                    Text("AI GENERATE IMAGES")
                }
                .padding(20)
                
                Image("Screenshot 2022-11-04 at 2.26.35 PM")
                    .resizable()
                    .frame(width: 300,height: 250)
                    .aspectRatio(contentMode: .fill)
                
                TextField(
                "Type to generate an image",
                text: $text,
                axis: .vertical
                ).textFieldStyle(.roundedBorder)
                
                .multilineTextAlignment(
                    .center)
//                Color.red
//                .background(Color.gray)
                    .padding(50)
                Button {
                    Task {
                        
                    }
                } label: {
                    Text("Generate Images")
                        .padding()
                        .font(.title2)
                        .buttonStyle(.borderedProminent)
                        .background(.pink)
                        .cornerRadius(10)
                        .tint(.white)
                }
                Spacer()
            }
            .navigationTitle("AI Image Generator")
            .multilineTextAlignment(.leading)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
