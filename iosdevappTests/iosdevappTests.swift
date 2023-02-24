//
//  iosdevappTests.swift
//  iosdevappTests
//
//  Created by Leonit Ejupi on 31.01.23.
//

import XCTest
@testable import iosdevapp

final class iosdevappTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }

    func testGenerateImage() async {
        let viewModel = GenerateImageViewModel(urlSession: URLSession.shared)
        let prompt = "Test Prompt"
        
        let expectation = XCTestExpectation(description: "Image generated")
        
        let cancellable = viewModel.$imageURL
            .sink { imageURL in
                if let imageURL = imageURL {
                    expectation.fulfill()
                    XCTAssertNotNil(imageURL)
                }
            }
        
        await viewModel.generateImage(withText: prompt)
        
        wait(for: [expectation], timeout: 10)
        cancellable.cancel()
    }
    
    func testSaveToGallery() {
        let viewImageModel = GenerateImageViewModel()
        viewImageModel.imageURL = URL(string: "https://example.com/image.png")
        viewImageModel.saveImageToGallery()
    }
  }
