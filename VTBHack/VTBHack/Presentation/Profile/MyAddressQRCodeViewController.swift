//
//  MyAddressQRCodeViewController.swift
//  VTBHack
//
//  Created by Aleksander Evtuhov on 14/09/2019.
//  Copyright © 2019 RxProject. All rights reserved.
//

import UIKit
import AVFoundation

class MyAddressQRCodeViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let adress = ServiceLayer.shared.infoService.accountAdress else { return }
        // Get define string to encode
        let qrModel = QRAddressDto(address: adress)
        
        let encoder = JSONEncoder()
        guard
            let encodedData = try? encoder.encode(qrModel),
            let myString = String(bytes: encodedData, encoding: .utf8)
            else { return }
        
        // Get data from the string
        let data = myString.data(using: String.Encoding.ascii)
        // Get a QR CIFilter
        guard let qrFilter = CIFilter(name: "CIQRCodeGenerator") else { return }
        // Input the data
        qrFilter.setValue(data, forKey: "inputMessage")
        // Get the output image
        guard let qrImage = qrFilter.outputImage else { return }
        // Scale the image
        let transform = CGAffineTransform(scaleX: 10, y: 10)
        let scaledQrImage = qrImage.transformed(by: transform)
        // Do some processing to get the UIImage
        let context = CIContext()
        guard let cgImage = context.createCGImage(scaledQrImage, from: scaledQrImage.extent) else { return }
        let processedImage = UIImage(cgImage: cgImage)
        imageView.image = processedImage
    }
}



