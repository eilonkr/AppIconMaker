//
//  ImagePickerDelegate.swift
//  AppIconMaker
//
//  Created by Eilon Krauthammer on 04/11/2020.
//

import UIKit

class ImagePickerDelegate: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    typealias Callback = (UIImage?) -> Void
    
    private var callback: Callback?
    
    var pickedImage: UIImage? {
        didSet {
            callback?(pickedImage)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            self.pickedImage = image
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.pickedImage = nil
    }
    
    public func onReceive(_ callback: @escaping Callback) {
        self.callback = callback
    }
    
}
