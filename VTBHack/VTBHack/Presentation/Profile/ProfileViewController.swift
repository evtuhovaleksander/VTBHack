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
    @IBOutlet var avatarImageView: UIImageView!
    @IBOutlet var avatarContainerView: UIView!
    
    @IBOutlet var nickNameLabel: UILabel!
    @IBOutlet var phoneLabel: UILabel!
    
    @IBOutlet var ceeperNameLabel: UILabel!
    @IBOutlet var keepBalanceLabel: UILabel!
    
    @IBOutlet var statusLabel: UILabel!
    
    @IBOutlet var identifierLabel: UILabel!
    
   
    let imagePicker = UIImagePickerController()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        headerView.backgroundColor = UIColor.Color.darkBlue
        view.backgroundColor = UIColor.Color.backgroundGray
        avatarImageView.tintColor = UIColor.Color.blueButtonBorder
        avatarImageView.image = UIImage.Image.profileSceleton
        nickNameLabel.textColor = .white
        nickNameLabel.text = "Павло Павел"
        phoneLabel.textColor = .white
        phoneLabel.text = "+98555555555"
        avatarContainerView.layer.cornerRadius = 32.0
        avatarContainerView.clipsToBounds = true
        
        ceeperNameLabel.text = "Кошелек"
        
        
        
        keepBalanceLabel.text = "\(900)Р"
        keepBalanceLabel.textColor = UIColor.Color.blueText
        
        identifierLabel.text = "+73267366723672"
        identifierLabel.textColor = UIColor.Color.darkGray
        
        statusLabel.text = "Доступен"
        statusLabel.textColor = UIColor.Color.statusGreen
    }
    
    @IBAction func actionButton(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
}

//extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//    func imagePickerController(_ picker: UIImagePickerController,
//                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        if let selectedImage = info[.originalImage] as? UIImage {
//            let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy : CIDetectorAccuracyHigh])!
//            let ciImage: CIImage = CIImage(image: selectedImage)!
//            var qrCodeLink: String? = nil
//
//            let features = detector.features(in: ciImage)
//            for feature in features as! [CIQRCodeFeature] {
//                qrCodeLink = feature.messageString
//            }
//            let decoder = JSONDecoder()
//            if
//                let qrCodeLink = qrCodeLink,
//                let data = qrCodeLink.data(using: .utf8),
//                let adressDto = try? decoder.decode(QRAddressDto.self, from: data) {
//
//            }else{
//
//            }
//
//        }
//        else{
//
//        }
//        imagePicker.dismiss(animated: true, completion: nil)
//    }
//}
