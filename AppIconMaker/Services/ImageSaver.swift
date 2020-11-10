//
//  ImageSaver.swift
//  AppIconMaker
//
//  Created by Eilon Krauthammer on 10/11/2020.
//

import UIKit

class ImageSaver: NSObject {
    private var completionHandler: (() -> Void)?
    
    func writeToPhotoAlbum(_ image: UIImage, completion: (() -> Void)?) {
        completionHandler = completion
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
    }

    @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        completionHandler?()
    }
}
