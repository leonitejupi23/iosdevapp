//
//  ContentView.swift
//  iosdevapp
//
//  Created by Leonit Ejupi on 31.01.23.
//


import SwiftUI

struct ContentView: View {
    @State private var text: String = ""

    var body: some View {
        ScrollView {
            VStack {
                Section {
                    Text("AI GENERATE IMAGES")
                }
                .padding(20)
                .font(.system(.title2, weight: .heavy))
                
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
