//
//  SaveImage.swift
//  iosdevapp
//
//  Created by Leonit Ejupi on 02.03.23.
//

import Foundation
import UIKit

extension GenerateImageViewModel {
    func saveImageToGallery() {
        guard let imageURL = imageURL else {
            return
        }
        DispatchQueue.global(qos: .background).async {
            let data = try! Data(contentsOf: imageURL)
            let image = UIImage(data: data)!
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        }
    }
}
