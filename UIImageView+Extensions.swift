//
//  UIImageView+Extensions.swift
//  NexPlay
//
//  Created by J Walcott on 8/6/25.
import UIKit
import Nuke
import NukeExtensions

extension UIImageView {
    func loadImage(from url: URL) {
        let options = ImageLoadingOptions(
            placeholder: UIImage(systemName: "photo"),
            transition: .fadeIn(duration: 0.3),
            failureImage: UIImage(systemName: "xmark.circle")
        )
        
        
        ImagePipeline.shared.loadImage(with: url) { result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.image = response.image
                }
            case .failure:
                DispatchQueue.main.async {
                    self.image = options.failureImage
                }
            }
        }
    }
}




