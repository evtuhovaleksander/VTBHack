//
//  TestSwift.swift
//  VTBHack
//
//  Created by Aleksander Evtuhov on 14/09/2019.
//  Copyright © 2019 RxProject. All rights reserved.
//

import UIKit
import AVFoundation

class ProfileViewController: UIViewController {
    @IBOutlet var headerView: UIView!
    
    @IBOutlet var lll: UILabel!
    let imagePicker = UIImagePickerController()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        headerView.backgroundColor = UIColor.Color.darkBlue
        imagePicker.delegate = self
    }
    
    @IBAction func actionButton(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy : CIDetectorAccuracyHigh])!
            let ciImage: CIImage = CIImage(image: selectedImage)!
            var qrCodeLink: String? = nil
            
            let features = detector.features(in: ciImage)
            for feature in features as! [CIQRCodeFeature] {
                qrCodeLink = feature.messageString
            }
            let decoder = JSONDecoder()
            if
                let qrCodeLink = qrCodeLink,
                let data = qrCodeLink.data(using: .utf8),
                let adressDto = try? decoder.decode(QRAddressDto.self, from: data) {
                lll.text = adressDto.address
                
            }else{
                
            }
            
        }
        else{
            
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
}
